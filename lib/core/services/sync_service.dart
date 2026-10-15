import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../local_db/isar_service.dart';
import '../../data/models/user_profile.dart';
import '../../data/models/food_log.dart';
import '../../data/models/weight_log.dart';
import '../../data/models/activity_log.dart';

import '../../data/models/sync_queue_item.dart';
import 'network_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return SyncService(IsarService.instance, networkService);
});

class SyncService {
  final Isar _isar;
  final NetworkService _networkService;

  FirebaseFirestore? get _db =>
      firebaseAvailable ? FirebaseFirestore.instance : null;
  // Helper to check if Firebase has been initialized
  bool get firebaseAvailable => Firebase.apps.isNotEmpty;
  FirebaseAuth? get _auth =>
      firebaseAvailable ? FirebaseAuth.instance : null;

  Timer? _debounceTimer;
  bool _isSyncing = false;
  Timer? _periodicSyncTimer;
  StreamSubscription? _networkSub;

  // --- Persistent Sync Queue ---
  static const int _maxRetry = 5;
  // UUID generator used for local-only identifiers if needed.
  // (Currently not used for sync payloads.)
  // final _uuid = const Uuid();

  /// Enqueue a sync operation. Returns the generated operationId.
  Future<String> enqueue({
    required SyncEntity entity,
    required int localId,
    required SyncAction action,
  }) async {
    final item = SyncQueueItem(
    entity: entity,
    localId: localId,
    action: action,
  );
  await _isar.writeTxn(() => _isar.syncQueueItems.put(item));
  // Ensure a debounce so the queue gets processed soon.
  requestSync();
  return item.operationId!;
  }

  /// Process all pending queue items respecting ordering and idempotency.
  Future<void> _processQueue() async {
    final items = await _isar.syncQueueItems.where().sortByQueuedAt().findAll();
    if (items.isEmpty) return;

    // Coalesce actions per (entity, localId) – keep only the latest action.
    final Map<String, SyncQueueItem> latest = {};
    for (final it in items) {
      final key = '${it.entity}-${it.localId}';
      latest[key] = it; // later items overwrite earlier ones due to sorting
    }
    final List<SyncQueueItem> work = latest.values.toList()
      ..sort((a, b) => a.queuedAt.compareTo(b.queuedAt));

    for (final item in work) {
      if (item.retryCount >= _maxRetry) {
        // Mark as failed and skip further attempts.
        await _isar.writeTxn(() async {
          item.lastError = 'Max retries exceeded';
          await _isar.syncQueueItems.put(item);
        });
        continue;
      }

      try {
        await _executeQueueItem(item);
        // On success remove the item.
        await _isar.writeTxn(() => _isar.syncQueueItems.delete(item.id!));
      } catch (e) {
        // Increment retry count and store error.
        await _isar.writeTxn(() async {
          item.retryCount += 1;
          item.lastError = e.toString();
          await _isar.syncQueueItems.put(item);
        });
      }
    }
  }

  /// Execute a single queue item.
  Future<void> _executeQueueItem(SyncQueueItem item) async {
    final db = _db;
    if (db == null) return;
    final uid = _auth?.currentUser?.uid;
    if (uid == null) return;

    // Resolve the local record based on entity.
    dynamic localRecord;
    switch (item.entity) {
      case SyncEntity.food:
        localRecord = await _isar.foodLogs.get(item.localId);
        break;
      case SyncEntity.weight:
        localRecord = await _isar.weightLogs.get(item.localId);
        break;
      case SyncEntity.activity:
        localRecord = await _isar.activityLogs.get(item.localId);
        break;
    }
    if (localRecord == null) {
      // Record no longer exists locally – treat as successful removal.
      return;
    }

    // Enforce ownership + guest isolation:
    // - Guest records must never sync automatically.
    // - Only records explicitly owned by the signed-in Firebase UID may sync.
    try {
      final bool isGuestData = (localRecord.isGuestData == true);
      final String? ownerUid = localRecord.ownerUid as String?;
      if (isGuestData || ownerUid != uid) {
        return;
      }
    } catch (_) {
      // If schema is missing fields for any reason, do not sync.
      return;
    }

    final collRef = db.collection('users').doc(uid);
    late DocumentReference docRef;
    // Decide Firestore sub‑collection based on entity.
    switch (item.entity) {
      case SyncEntity.food:
        docRef = collRef.collection('food_logs').doc(localRecord.firebaseId ?? collRef.collection('food_logs').doc().id);
        break;
      case SyncEntity.weight:
        docRef = collRef.collection('weight_logs').doc(localRecord.firebaseId ?? collRef.collection('weight_logs').doc().id);
        break;
      case SyncEntity.activity:
        docRef = collRef.collection('activity_logs').doc(localRecord.firebaseId ?? collRef.collection('activity_logs').doc().id);
        break;
    }

    // Attach operationId for idempotency on creates/updates.
    final Map<String, dynamic> payload = {
      'operationId': item.operationId,
    };

    // Populate payload depending on entity fields.
    if (item.entity == SyncEntity.food) {
      payload.addAll({
        'foodId': localRecord.foodItemId,
        'foodName': localRecord.foodName,
        'calories': localRecord.totalCalories,
        'protein': localRecord.totalProtein,
        'carbs': localRecord.totalCarbs,
        'fat': localRecord.totalFat,
        'fiber': localRecord.totalFiber,
        'sugar': localRecord.totalSugar,
        'loggedAt': Timestamp.fromDate(localRecord.loggedAt),
      });
    } else if (item.entity == SyncEntity.weight) {
      payload.addAll({
        'weight': localRecord.weight,
        'loggedAt': Timestamp.fromDate(localRecord.loggedAt),
        'notes': localRecord.notes,
      });
    } else if (item.entity == SyncEntity.activity) {
      payload.addAll({
        'type': localRecord.activityType.name,
        'steps': localRecord.steps,
        'durationMinutes': localRecord.durationMinutes,
        'loggedAt': Timestamp.fromDate(localRecord.loggedAt),
      });
    }

    if (item.action == SyncAction.delete) {
      // Delete is safe – Firestore silently ignores missing docs.
      await docRef.delete();
      // Physically delete locally.
      await _isar.writeTxn(() async {
        switch (item.entity) {
          case SyncEntity.food:
            await _isar.foodLogs.delete(item.localId);
            break;
          case SyncEntity.weight:
            await _isar.weightLogs.delete(item.localId);
            break;
          case SyncEntity.activity:
            await _isar.activityLogs.delete(item.localId);
            break;
        }
      });
    } else {
      // Create or update – use set with merge and include operationId.
      await docRef.set(payload, SetOptions(merge: true));
    }
  }

  SyncService(this._isar, this._networkService) {
    if (firebaseAvailable) {
      // Process any pending changes that may exist from a previous session
      requestSync();
    }
      _networkSub = _networkService.onConnectivityChanged.listen((status) {
        if (status != ConnectivityResult.none) {
          requestSync();
        }
      });
    }
  

  void dispose() {
    _networkSub?.cancel();
    stopPeriodicSync();
    _debounceTimer?.cancel();
  }

  void startPeriodicSync() {
    if (!firebaseAvailable) return;
    _periodicSyncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _performSyncBatch();
    });
  }

  void stopPeriodicSync() {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = null;
  }

  /// Debounces sync requests. After the timer fires we process the persistent
  /// queue and also run a profile/logs batch sync.
  void requestSync() {
    if (!firebaseAvailable) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 15), () async {
      await _processQueue();
      await _performSyncBatch();
    });
  }

  Future<void> _performSyncBatch() async {
    if (!firebaseAvailable) return;
    if (_isSyncing) return;
    final user = _auth?.currentUser;
    if (user == null) return;

    _isSyncing = true;
    try {
      await _syncUserProfile(user.uid);
      await _syncFoodLogs(user.uid);
      await _syncActivityLogs(user.uid);
      await _syncWeightLogs(user.uid);
    } catch (e) {
      debugPrint('Sync Error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncUserProfile(String uid) async {
    final db = _db;
    if (db == null) return;

    final docRef = db.collection('users').doc(uid);
    DocumentSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (e) {
      debugPrint('[Sync] Profile fetch failed: $e');
      return;
    }

    var localProfile = await _isar.userProfiles
        .filter()
        .uidEqualTo(uid)
        .findFirst();

    // Reinstall / fresh device: no local row — restore from cloud if present.
    if (localProfile == null) {
      final remote = docSnap.data() as Map<String, dynamic>?;
      if (docSnap.exists && remote != null) {
        final restored = UserProfile()..uid = uid;
        _applyRemoteFields(restored, remote);
        await _isar.writeTxn(() async {
          await _isar.userProfiles.put(restored);
        });
        debugPrint(
            '[Sync] Restored profile from cloud (onboardingComplete=${restored.onboardingComplete})');
      }
      return;
    }

    bool pushToRemote = true;
    final remoteData = docSnap.data() as Map<String, dynamic>?;
    if (docSnap.exists && remoteData != null) {
      final remoteUpdatedAt =
          (remoteData['updatedAt'] as Timestamp?)?.toDate();

      // Remote wins if newer — full field restore for returning users.
      if (remoteUpdatedAt != null &&
          remoteUpdatedAt.isAfter(localProfile.updatedAt)) {
        await _isar.writeTxn(() async {
          _applyRemoteFields(localProfile, remoteData);
          localProfile.updatedAt = remoteUpdatedAt;
          await _isar.userProfiles.put(localProfile);
        });
        pushToRemote = false;
      } else if ((remoteData['onboardingComplete'] == true) &&
          !localProfile.onboardingComplete) {
        // Local incomplete but cloud completed (e.g. reinstall).
        await _isar.writeTxn(() async {
          _applyRemoteFields(localProfile, remoteData);
          await _isar.userProfiles.put(localProfile);
        });
        pushToRemote = false;
      }
    }

    if (pushToRemote) {
      try {
        await docRef.set(
          _profileToRemoteMap(localProfile),
          SetOptions(merge: true),
        );
      } catch (e) {
        debugPrint('[Sync] Profile push failed: $e');
      }
    }
  }

  /// Ensures local Isar has the user's profile, restoring from Firestore when
  /// needed (reinstall / clear data). Call before routing to onboarding.
  Future<UserProfile?> ensureUserProfile(String uid) async {
    if (uid.isEmpty) return null;
    try {
      await _syncUserProfile(uid);
    } catch (e) {
      debugPrint('[Sync] ensureUserProfile failed: $e');
    }
    return _isar.userProfiles.filter().uidEqualTo(uid).findFirst();
  }

  /// Immediately push local profile to Firestore (after onboarding / edit).
  Future<void> pushUserProfileNow(String uid) async {
    final db = _db;
    if (db == null || uid.isEmpty) return;
    final localProfile = await _isar.userProfiles
        .filter()
        .uidEqualTo(uid)
        .findFirst();
    if (localProfile == null) return;
    try {
      await db.collection('users').doc(uid).set(
            _profileToRemoteMap(localProfile),
            SetOptions(merge: true),
          );
      debugPrint('[Sync] Profile pushed for uid=$uid');
    } catch (e) {
      debugPrint('[Sync] pushUserProfileNow failed: $e');
    }
  }

  void _applyRemoteFields(UserProfile profile, Map<String, dynamic> remote) {
    profile
      ..name = (remote['name'] as String?)?.trim().isNotEmpty == true
          ? remote['name'] as String
          : profile.name
      ..email = (remote['email'] as String?) ?? profile.email
      ..age = (remote['age'] as num?)?.toInt() ?? profile.age
      ..weight = (remote['weight'] as num?)?.toDouble() ?? profile.weight
      ..height = (remote['height'] as num?)?.toDouble() ?? profile.height
      ..goalWeight = (remote['goalWeight'] as num?)?.toDouble() ?? profile.goalWeight
      ..bmr = (remote['bmr'] as num?)?.toDouble() ?? profile.bmr
      ..tdee = (remote['tdee'] as num?)?.toDouble() ?? profile.tdee
      ..dailyCalorieTarget =
          (remote['dailyCalorieTarget'] as num?)?.toInt() ??
              profile.dailyCalorieTarget
      ..dailyProteinTarget =
          (remote['dailyProteinTarget'] as num?)?.toInt() ??
              profile.dailyProteinTarget
      ..dailyCarbsTarget =
          (remote['dailyCarbsTarget'] as num?)?.toInt() ??
              profile.dailyCarbsTarget
      ..dailyFatTarget =
          (remote['dailyFatTarget'] as num?)?.toInt() ?? profile.dailyFatTarget
      ..waistCm = (remote['waistCm'] as num?)?.toDouble() ?? profile.waistCm
      ..neckCm = (remote['neckCm'] as num?)?.toDouble() ?? profile.neckCm
      ..hipCm = (remote['hipCm'] as num?)?.toDouble() ?? profile.hipCm
      ..sleepHours =
          (remote['sleepHours'] as num?)?.toInt() ?? profile.sleepHours
      ..dailyStepEstimate =
          (remote['dailyStepEstimate'] as num?)?.toInt() ??
              profile.dailyStepEstimate
      ..onboardingComplete =
          remote['onboardingComplete'] as bool? ?? profile.onboardingComplete
      ..isGuest = false;

    final gender = remote['gender'] as String?;
    if (gender != null) {
      profile.gender = Gender.values.firstWhere(
        (e) => e.name == gender,
        orElse: () => profile.gender,
      );
    }
    final goal = remote['goal'] as String?;
    if (goal != null) {
      profile.goal = UserGoal.values.firstWhere(
        (e) => e.name == goal,
        orElse: () => profile.goal,
      );
    }
    final activity = remote['activityLevel'] as String?;
    if (activity != null) {
      profile.activityLevel = ActivityLevel.values.firstWhere(
        (e) => e.name == activity,
        orElse: () => profile.activityLevel,
      );
    }
    final diet = remote['dietPreference'] as String?;
    if (diet != null) {
      profile.dietPreference = DietPreference.values.firstWhere(
        (e) => e.name == diet,
        orElse: () => profile.dietPreference,
      );
    }

    final updatedAt = (remote['updatedAt'] as Timestamp?)?.toDate();
    if (updatedAt != null) profile.updatedAt = updatedAt;
  }

  Map<String, dynamic> _profileToRemoteMap(UserProfile localProfile) {
    return {
      'name': localProfile.name,
      'email': localProfile.email,
      'gender': localProfile.gender.name,
      'age': localProfile.age,
      'weight': localProfile.weight,
      'height': localProfile.height,
      'goalWeight': localProfile.goalWeight,
      'activityLevel': localProfile.activityLevel.name,
      'goal': localProfile.goal.name,
      'dietPreference': localProfile.dietPreference.name,
      'bmr': localProfile.bmr,
      'tdee': localProfile.tdee,
      'dailyCalorieTarget': localProfile.dailyCalorieTarget,
      'dailyProteinTarget': localProfile.dailyProteinTarget,
      'dailyCarbsTarget': localProfile.dailyCarbsTarget,
      'dailyFatTarget': localProfile.dailyFatTarget,
      'waistCm': localProfile.waistCm,
      'neckCm': localProfile.neckCm,
      'hipCm': localProfile.hipCm,
      'sleepHours': localProfile.sleepHours,
      'dailyStepEstimate': localProfile.dailyStepEstimate,
      'onboardingComplete': localProfile.onboardingComplete,
      'updatedAt': Timestamp.fromDate(localProfile.updatedAt),
    };
  }

  Future<void> _syncFoodLogs(String uid) async {
    final db = _db;
    if (db == null) return;
    final collRef = db.collection('users').doc(uid).collection('food_logs');
    
    // 1. Pull from Remote (Remote Wins)
    final remoteSnap = await collRef.get();
    await _isar.writeTxn(() async {
      for (var doc in remoteSnap.docs) {
        final data = doc.data();
        final firebaseId = doc.id;
        final localDoc = await _isar.foodLogs.filter().firebaseIdEqualTo(firebaseId).findFirst();
        
        if (localDoc == null) {
          final newLog = FoodLog()
            ..uid = uid
            ..ownerUid = uid
            ..isGuestData = false
            ..firebaseId = firebaseId
            ..foodItemId = data['foodId'] ?? 0
            ..foodName = data['foodName']
            ..totalCalories = (data['calories'] ?? 0).toDouble()
            ..totalProtein = (data['protein'] ?? 0).toDouble()
            ..totalCarbs = (data['carbs'] ?? 0).toDouble()
            ..totalFat = (data['fat'] ?? 0).toDouble()
            ..totalFiber = (data['fiber'] ?? 0).toDouble()
            ..totalSugar = (data['sugar'] ?? 0).toDouble()
            ..satietyScore = (data['satietyScore'] ?? 5.0).toDouble()
            ..waterPercentage = (data['waterPercentage'] ?? 0).toDouble()
            ..isLiquid = data['isLiquid'] ?? false
            ..isUltraProcessed = data['isUltraProcessed'] ?? false
            ..quantity = (data['quantityGrams'] ?? 100).toDouble()
            ..loggedAt = (data['loggedAt'] as Timestamp?)?.toDate() ?? DateTime.now()
            ..isSynced = true
            ..isDeleted = false;
            
          final mealStr = data['mealType'] as String?;
          if (mealStr != null) {
            newLog.mealType = MealType.values.firstWhere((e) => e.name == mealStr, orElse: () => MealType.lunch);
          }
          await _isar.foodLogs.put(newLog);
        } else {
           // Overwrite local with remote fields unconditionally (Remote Wins)
           localDoc
            ..foodItemId = data['foodId'] ?? localDoc.foodItemId
            ..totalCalories = (data['calories'] ?? localDoc.totalCalories).toDouble()
            ..isSynced = true;
           await _isar.foodLogs.put(localDoc);
        }
      }
    });

    // 2. Push to Remote & Handle Deletions
    final unsyncedLogs = await _isar.foodLogs
        .filter()
        .isSyncedEqualTo(false)
        .ownerUidEqualTo(uid)
        .isGuestDataEqualTo(false)
        .findAll();
    if (unsyncedLogs.isEmpty) return;

    final batch = db.batch();
    List<Id> toPhysicallyDelete = [];

    for (final log in unsyncedLogs) {
      if (log.isDeleted) {
        if (log.firebaseId != null && log.firebaseId!.isNotEmpty) {
           batch.delete(collRef.doc(log.firebaseId));
        }
        toPhysicallyDelete.add(log.id);
        continue;
      }

      final docRef = log.firebaseId != null && log.firebaseId!.isNotEmpty 
          ? collRef.doc(log.firebaseId) 
          : collRef.doc();
      log.firebaseId = docRef.id;
      
      batch.set(docRef, {
        'foodId': log.foodItemId,
        'foodName': log.foodName,
        'calories': log.totalCalories,
        'protein': log.totalProtein,
        'carbs': log.totalCarbs,
        'fat': log.totalFat,
        'fiber': log.totalFiber,
        'sugar': log.totalSugar,
        'satietyScore': log.satietyScore,
        'waterPercentage': log.waterPercentage,
        'isLiquid': log.isLiquid,
        'isUltraProcessed': log.isUltraProcessed,
        'quantityGrams': log.quantity,
        'mealType': log.mealType.name,
        'loggedAt': Timestamp.fromDate(log.loggedAt),
      });
    }
    await batch.commit();

    await _isar.writeTxn(() async {
      for (final log in unsyncedLogs) {
        if (!log.isDeleted) {
          log.isSynced = true;
          await _isar.foodLogs.put(log);
        }
      }
      for (final id in toPhysicallyDelete) {
        await _isar.foodLogs.delete(id);
      }
    });
  }

  Future<void> _syncActivityLogs(String uid) async {
    final db = _db;
    if (db == null) return;
    final collRef = db.collection('users').doc(uid).collection('activity_logs');
    
    // 1. Pull from Remote
    final remoteSnap = await collRef.get();
    await _isar.writeTxn(() async {
      for (var doc in remoteSnap.docs) {
        final data = doc.data();
        final firebaseId = doc.id;
        final localDoc = await _isar.activityLogs.filter().firebaseIdEqualTo(firebaseId).findFirst();
        
        if (localDoc == null) {
          final newLog = ActivityLog()
            ..uid = uid
            ..ownerUid = uid
            ..isGuestData = false
            ..firebaseId = firebaseId
            ..steps = data['steps'] ?? 0
            ..workoutName = data['workoutName']
            ..durationMinutes = data['durationMinutes'] ?? 0
            ..estimatedCaloriesBurned = data['estimatedCaloriesBurned'] ?? 0
            ..sets = data['sets'] ?? 0
            ..reps = data['reps'] ?? 0
            ..date = (data['date'] as Timestamp?)?.toDate() ?? DateTime.now()
            ..loggedAt = (data['date'] as Timestamp?)?.toDate() ?? DateTime.now()
            ..isSynced = true
            ..isDeleted = false;
            
          final typeStr = data['type'] as String?;
          if (typeStr != null) {
            newLog.activityType = ActivityType.values.firstWhere((e) => e.name == typeStr, orElse: () => ActivityType.steps);
          }
          await _isar.activityLogs.put(newLog);
        } else {
           localDoc.isSynced = true;
           await _isar.activityLogs.put(localDoc);
        }
      }
    });

    // 2. Push to Remote & Handle Deletions
    final unsyncedLogs = await _isar.activityLogs
        .filter()
        .isSyncedEqualTo(false)
        .ownerUidEqualTo(uid)
        .isGuestDataEqualTo(false)
        .findAll();
    if (unsyncedLogs.isEmpty) return;

    final batch = db.batch();
    List<Id> toPhysicallyDelete = [];

    for (final log in unsyncedLogs) {
      if (log.isDeleted) {
        if (log.firebaseId != null && log.firebaseId!.isNotEmpty) {
           batch.delete(collRef.doc(log.firebaseId));
        }
        toPhysicallyDelete.add(log.id);
        continue;
      }

      final docRef = log.firebaseId != null && log.firebaseId!.isNotEmpty 
          ? collRef.doc(log.firebaseId) 
          : collRef.doc();
      log.firebaseId = docRef.id;
      
      batch.set(docRef, {
        'type': log.activityType.name,
        'steps': log.steps,
        'workoutName': log.workoutName,
        'durationMinutes': log.durationMinutes,
        'estimatedCaloriesBurned': log.estimatedCaloriesBurned,
        'sets': log.sets,
        'reps': log.reps,
        'date': Timestamp.fromDate(log.date),
      });
    }
    await batch.commit();

    await _isar.writeTxn(() async {
      for (final log in unsyncedLogs) {
        if (!log.isDeleted) {
          log.isSynced = true;
          await _isar.activityLogs.put(log);
        }
      }
      for (final id in toPhysicallyDelete) {
        await _isar.activityLogs.delete(id);
      }
    });
  }

  Future<void> _syncWeightLogs(String uid) async {
    final db = _db;
    if (db == null) return;
    final collRef = db.collection('users').doc(uid).collection('weight_logs');
    
    // 1. Pull from Remote
    final remoteSnap = await collRef.get();
    await _isar.writeTxn(() async {
      for (var doc in remoteSnap.docs) {
        final data = doc.data();
        final firebaseId = doc.id;
        final localDoc = await _isar.weightLogs.filter().firebaseIdEqualTo(firebaseId).findFirst();
        
        if (localDoc == null) {
          final newLog = WeightLog()
            ..uid = uid
            ..ownerUid = uid
            ..isGuestData = false
            ..firebaseId = firebaseId
            ..weight = (data['weight'] ?? 0).toDouble()
            ..notes = data['notes']
            ..loggedAt = (data['loggedAt'] as Timestamp?)?.toDate() ?? DateTime.now()
            ..date = (data['loggedAt'] as Timestamp?)?.toDate() ?? DateTime.now()
            ..isSynced = true
            ..isDeleted = false;
          await _isar.weightLogs.put(newLog);
        } else {
           localDoc.isSynced = true;
           await _isar.weightLogs.put(localDoc);
        }
      }
    });

    // 2. Push to Remote & Handle Deletions
    final unsyncedLogs = await _isar.weightLogs
        .filter()
        .isSyncedEqualTo(false)
        .ownerUidEqualTo(uid)
        .isGuestDataEqualTo(false)
        .findAll();
    if (unsyncedLogs.isEmpty) return;

    final batch = db.batch();
    List<Id> toPhysicallyDelete = [];

    for (final log in unsyncedLogs) {
      if (log.isDeleted) {
        if (log.firebaseId != null && log.firebaseId!.isNotEmpty) {
           batch.delete(collRef.doc(log.firebaseId));
        }
        toPhysicallyDelete.add(log.id);
        continue;
      }

      final docRef = log.firebaseId != null && log.firebaseId!.isNotEmpty 
          ? collRef.doc(log.firebaseId) 
          : collRef.doc();
      log.firebaseId = docRef.id;
      
      batch.set(docRef, {
        'weight': log.weight,
        'loggedAt': Timestamp.fromDate(log.loggedAt),
        'notes': log.notes,
      });
    }
    await batch.commit();

    await _isar.writeTxn(() async {
      for (final log in unsyncedLogs) {
        if (!log.isDeleted) {
          log.isSynced = true;
          await _isar.weightLogs.put(log);
        }
      }
      for (final id in toPhysicallyDelete) {
        await _isar.weightLogs.delete(id);
      }
    });
  }
}
