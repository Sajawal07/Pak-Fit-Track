import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/local_db/isar_service.dart';
import '../models/weight_log.dart';
import '../models/activity_log.dart';
import '../models/sync_queue_item.dart';
import '../../core/services/sync_service.dart';
import '../../providers/auth_provider.dart';

class WeightRepository {
  final Isar _db;
  final Ref _ref;
  WeightRepository(this._db, this._ref);

  Future<void> logWeight(WeightLog log) async {
    final firebaseUser = _ref.read(authStateProvider).value;
    log.ownerUid = firebaseUser?.uid;
    log.isGuestData = firebaseUser == null;
    await _db.writeTxn(() async {
      await _db.weightLogs.put(log);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.weight,
      localId: log.id,
      action: SyncAction.create,
    );
  }

  Future<WeightLog?> getLatestWeight(String uid) async {
    return _db.weightLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .sortByLoggedAtDesc()
        .findFirst();
  }

  Future<List<WeightLog>> getLast30Days(String uid) async {
    final from = DateTime.now().subtract(const Duration(days: 30));
    return _db.weightLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtGreaterThan(from)
        .sortByLoggedAt()
        .findAll();
  }

  Future<List<WeightLog>> getLast7Days(String uid) async {
    final from = DateTime.now().subtract(const Duration(days: 7));
    return _db.weightLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtGreaterThan(from)
        .sortByLoggedAt()
        .findAll();
  }

  Future<void> deleteWeight(Id id) async {
    final log = await _db.weightLogs.get(id);
    if (log == null) return;
    log.isDeleted = true;
    log.isSynced = false;
    await _db.writeTxn(() async {
      await _db.weightLogs.put(log);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.weight,
      localId: id,
      action: SyncAction.delete,
    );
  }

  Stream<List<WeightLog>> watchWeightLogs(String uid) {
    final from = DateTime.now().subtract(const Duration(days: 30));
    return _db.weightLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtGreaterThan(from)
        .watch(fireImmediately: true);
  }
}

class ActivityRepository {
  final Isar _db;
  final Ref _ref;
  ActivityRepository(this._db, this._ref);

  Future<void> logActivity(ActivityLog log) async {
    final firebaseUser = _ref.read(authStateProvider).value;
    log.ownerUid = firebaseUser?.uid;
    log.isGuestData = firebaseUser == null;
    await _db.writeTxn(() async {
      await _db.activityLogs.put(log);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.activity,
      localId: log.id,
      action: SyncAction.create,
    );
  }

  Future<List<ActivityLog>> getLogsForDate(String uid, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return _db.activityLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtBetween(start, end)
        .findAll();
  }

  Future<ActivityLog?> getTodayStepLog(String uid) async {
    final start = DateTime.now();
    final dayStart = DateTime(start.year, start.month, start.day);
    final dayEnd = DateTime(start.year, start.month, start.day, 23, 59, 59);
    return _db.activityLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .activityTypeEqualTo(ActivityType.steps)
        .loggedAtBetween(dayStart, dayEnd)
        .findFirst();
  }

  Future<void> updateOrCreateStepLog(String uid, int steps) async {
    var log = await getTodayStepLog(uid);
    if (log == null) {
      log = ActivityLog()
        ..uid = uid
        ..ownerUid = _ref.read(authStateProvider).value?.uid
        ..isGuestData = (_ref.read(authStateProvider).value == null)
        ..activityType = ActivityType.steps
        ..steps = steps
        ..loggedAt = DateTime.now()
        ..date = DateTime.now();
    } else {
      // Monotonic reconcile: never overwrite a higher step count with a lower one
      // (prevents delayed Health data or late streams from corrupting totals).
      if (steps > log.steps) {
        log.steps = steps;
      }
    }
    await _db.writeTxn(() async {
      await _db.activityLogs.put(log!);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.activity,
      localId: log.id,
      action: SyncAction.create,
    );
  }

  Future<ActivityLog?> getTodayStepLogForDate(String uid, DateTime start, DateTime end) async {
    return _db.activityLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .activityTypeEqualTo(ActivityType.steps)
        .loggedAtBetween(start, end)
        .findFirst();
  }

  Future<void> updateOrCreateStepLogForDate(String uid, int steps, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    var log = await getTodayStepLogForDate(uid, start, end);
    if (log == null) {
      log = ActivityLog()
        ..uid = uid
        ..activityType = ActivityType.steps
        ..steps = steps
        ..loggedAt = date
        ..date = DateTime(date.year, date.month, date.day);
    } else {
      if (steps > log.steps) {
        log.steps = steps;
      }
    }
    await _db.writeTxn(() async {
      await _db.activityLogs.put(log!);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.activity,
      localId: log.id,
      action: SyncAction.create,
    );
  }

  Future<List<ActivityLog>> getLast7DaysSteps(String uid) async {
    final from = DateTime.now().subtract(const Duration(days: 7));
    return _db.activityLogs
        .filter()
        .uidEqualTo(uid)
        .activityTypeEqualTo(ActivityType.steps)
        .loggedAtGreaterThan(from)
        .sortByLoggedAt()
        .findAll();
  }

  Future<void> deleteActivity(Id id) async {
    final log = await _db.activityLogs.get(id);
    if (log == null) return;
    log.isDeleted = true;
    log.isSynced = false;
    await _db.writeTxn(() async {
      await _db.activityLogs.put(log);
    });
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.activity,
      localId: id,
      action: SyncAction.delete,
    );
  }

  /// Marks all step logs for [uid] in the last [days] as deleted.
  /// Used to cleanup guest logs after migration.
  Future<void> deleteRecentStepLogsForUid(String uid, {int days = 7}) async {
    final from = DateTime.now().subtract(Duration(days: days));
    final logs = await _db.activityLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .activityTypeEqualTo(ActivityType.steps)
        .loggedAtGreaterThan(from)
        .findAll();

    if (logs.isEmpty) return;
    await _db.writeTxn(() async {
      for (final l in logs) {
        l.isDeleted = true;
        l.isSynced = false;
        await _db.activityLogs.put(l);
      }
    });
  }
}

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  return WeightRepository(IsarService.instance, ref);
});

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository(IsarService.instance, ref);
});
