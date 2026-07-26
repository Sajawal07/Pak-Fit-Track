import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/prefs_keys.dart';
import '../local_db/isar_service.dart';
import '../../data/models/activity_log.dart';
import '../../data/models/user_profile.dart';
import '../../data/models/food_item.dart';
import '../../data/models/food_log.dart';
import '../../data/models/notification_log.dart';
import '../../data/models/sync_queue_item.dart';
import '../../data/models/water_log.dart';
import '../../data/models/weight_log.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';

final accountDeletionServiceProvider =
    Provider<AccountDeletionService>((ref) {
  return AccountDeletionService(ref);
});

/// Server-side backup: install Firebase Extension "Delete User Data" — see
/// docs/FIREBASE_DELETE_USER_DATA.md (runs when Auth user is deleted).

/// All Firestore subcollections written by [SyncService].
const _firestoreSubcollections = [
  'food_logs',
  'weight_logs',
  'activity_logs',
];

class AccountDeletionService {
  final Ref _ref;
  AccountDeletionService(this._ref);

  FirebaseFirestore? get _db =>
      firebaseAvailable ? FirebaseFirestore.instance : null;

  FirebaseAuth? get _auth =>
      firebaseAvailable ? FirebaseAuth.instance : null;

  /// Deletes Firebase Auth user, all Firestore user data, local Isar user data, and prefs.
  Future<void> deleteAccount() async {
    final auth = _auth;
    final user = auth?.currentUser;
    final uid = user != null
        ? user.uid
        : _ref.read(currentUidProvider);
    if (uid.isEmpty) {
      await _ref.read(authNotifierProvider.notifier).signOut();
      return;
    }

    if (user != null) {
      await _deleteFirestoreUserData(user.uid);
      try {
        await user.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          throw Exception(
            'For security, please sign out, sign in again, then delete your account.',
          );
        }
        rethrow;
      }
    }

    await _clearLocalUserData(uid);
    await _clearUserPreferences();
    await _ref.read(authNotifierProvider.notifier).signOut();
  }

  /// Guest: clears local data and prefs only.
  Future<void> deleteGuestData() async {
    final uid = _ref.read(currentUidProvider);
    if (uid.isEmpty) return;
    await _clearLocalUserData(uid);
    await _clearUserPreferences();
    await _ref.read(authNotifierProvider.notifier).signOut();
  }

  Future<void> _deleteFirestoreUserData(String uid) async {
    final db = _db;
    if (db == null) return;

    final userRef = db.collection('users').doc(uid);

    for (final sub in _firestoreSubcollections) {
      await _deleteCollectionFully(userRef.collection(sub));
    }

    await userRef.delete();

    await _verifyFirestoreUserRemoved(uid);
  }

  Future<void> _deleteCollectionFully(
    CollectionReference<Map<String, dynamic>> col,
  ) async {
    final db = _db!;
    while (true) {
      final snap = await col.limit(100).get();
      if (snap.docs.isEmpty) break;
      final batch = db.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    // Verify empty (catches partial batch failures)
    final remaining = await col.limit(1).get();
    if (remaining.docs.isNotEmpty) {
      throw Exception(
        'Could not delete all cloud logs. Check network and try again.',
      );
    }
  }

  Future<void> _verifyFirestoreUserRemoved(String uid) async {
    final db = _db!;
    final userRef = db.collection('users').doc(uid);
    final doc = await userRef.get();
    if (doc.exists) {
      throw Exception('Account data still exists on server. Please retry.');
    }
    for (final sub in _firestoreSubcollections) {
      final left = await userRef.collection(sub).limit(1).get();
      if (left.docs.isNotEmpty) {
        debugPrint('AccountDeletion: orphan docs in $sub for $uid');
        throw Exception(
          'Some cloud data could not be removed. Please contact support.',
        );
      }
    }
  }

  Future<void> _clearLocalUserData(String uid) async {
    final isar = IsarService.instance;
    await isar.writeTxn(() async {
      await isar.userProfiles.filter().uidEqualTo(uid).deleteAll();
      await isar.foodLogs.filter().uidEqualTo(uid).deleteAll();
      await isar.weightLogs.filter().uidEqualTo(uid).deleteAll();
      await isar.activityLogs.filter().uidEqualTo(uid).deleteAll();
      await isar.waterLogs.filter().uidEqualTo(uid).deleteAll();
      await isar.notificationLogs.filter().uidEqualTo(uid).deleteAll();
      // User-created custom foods (no uid on model — remove on account wipe)
      await isar.foodItems.filter().isCustomEqualTo(true).deleteAll();
      await isar.syncQueueItems.where().deleteAll();
    });
  }

  Future<void> _clearUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    for (final key in PrefsKeys.deletableOnAccountRemoval) {
      await prefs.remove(key);
    }
  }
}
