import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../main.dart';
import '../../data/models/activity_log.dart';
import '../../data/models/food_log.dart';
import '../../data/models/notification_log.dart';
import '../../data/models/sync_queue_item.dart';
import '../../data/models/user_profile.dart';
import '../../data/models/water_log.dart';
import '../../data/models/weight_log.dart';
import '../constants/prefs_keys.dart';
import '../local_db/isar_service.dart';
import 'notification_service.dart';
import 'step_tracker_service.dart';

final accountLocalCleanupServiceProvider =
    Provider<AccountLocalCleanupService>((ref) {
  return AccountLocalCleanupService(ref);
});

/// Removes LOCAL device data that belongs to a specific user right after
/// their account-deletion REQUEST has been successfully recorded in
/// Firestore (`deletionRequests/{uid}`).
///
/// Scope — every Isar query is uid-scoped, so other users' local records
/// (if any) are never touched:
/// - Isar: user profile, food/weight/activity/water logs (including
///   soft-deleted rows), notification logs, and sync-queue items that
///   pointed at the deleted records.
/// - SharedPreferences: only the keys declared in
///   [PrefsKeys.deletableOnAccountRemoval] — never `prefs.clear()`.
/// - Notifications: shown and scheduled local notifications. The generic
///   9 PM reminder is re-scheduled by [NotificationService.init] on the
///   next app start; its text contains no personal data.
/// - Android native: step history (Room `daily_steps`) and step-tracker
///   preferences (`pakfittrack_steps`) via the `pakfittrack/steps_store`
///   channel. No-op on iOS (channel not registered there).
///
/// This class does NOT delete anything in the cloud. Cloud records
/// (Firebase Authentication account, `users/{uid}` and its subcollections)
/// are deleted manually by the administrator following
/// `docs/ACCOUNT_DELETION.md`.
class AccountLocalCleanupService {
  AccountLocalCleanupService(this._ref);

  final Ref _ref;

  /// Clears local data for [uid]. Safe to call after the deletion request
  /// has been confirmed by Firestore; performs no network operations and
  /// cannot recreate cloud records.
  Future<void> clearLocalDataForDeletionRequest(String uid) async {
    if (uid.isEmpty) return;

    // 1. Stop the step-tracker foreground service FIRST so it cannot
    //    rewrite native step rows while we clear them. Step tracking can be
    //    re-enabled later from Profile → Privacy & data after signing in.
    try {
      await _ref.read(stepTrackerServiceProvider).stop();
    } catch (_) {
      // Best-effort: continue cleanup even if the native stop fails.
    }

    // 2. Cancel shown + scheduled local notifications.
    try {
      await _ref.read(notificationServiceProvider).cancelAllNotifications();
    } catch (_) {}

    // 3. Isar — delete only records owned by [uid].
    await _clearIsarDataForUid(uid);

    // 4. SharedPreferences — only the declared user-specific keys.
    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      for (final key in PrefsKeys.deletableOnAccountRemoval) {
        await prefs.remove(key);
      }
    } catch (_) {}

    // 5. Native Android step store (Room `daily_steps` rows + the whole
    //    `pakfittrack_steps` prefs file, which belongs to the step tracker).
    //    Channel is Android-only — MissingPluginException on other platforms
    //    is expected and ignored.
    try {
      await const MethodChannel('pakfittrack/steps_store')
          .invokeMethod('clearAllData');
    } catch (_) {}
  }

  Future<void> _clearIsarDataForUid(String uid) async {
    final isar = IsarService.instance;

    await isar.writeTxn(() async {
      // Profile rows for this uid (normally exactly one).
      final profiles =
          await isar.userProfiles.filter().uidEqualTo(uid).findAll();
      await isar.userProfiles.deleteAll(profiles.map((e) => e.id).toList());

      // Fitness logs — match either uid field so every write path is
      // covered (providers set `uid`; repositories set `ownerUid`).
      final foodLogs = await isar.foodLogs
          .filter()
          .uidEqualTo(uid)
          .or()
          .ownerUidEqualTo(uid)
          .findAll();
      await isar.foodLogs.deleteAll(foodLogs.map((e) => e.id).toList());

      final weightLogs = await isar.weightLogs
          .filter()
          .uidEqualTo(uid)
          .or()
          .ownerUidEqualTo(uid)
          .findAll();
      await isar.weightLogs.deleteAll(weightLogs.map((e) => e.id).toList());

      final activityLogs = await isar.activityLogs
          .filter()
          .uidEqualTo(uid)
          .or()
          .ownerUidEqualTo(uid)
          .findAll();
      await isar.activityLogs
          .deleteAll(activityLogs.map((e) => e.id).toList());

      final waterLogs = await isar.waterLogs
          .filter()
          .uidEqualTo(uid)
          .or()
          .ownerUidEqualTo(uid)
          .findAll();
      await isar.waterLogs.deleteAll(waterLogs.map((e) => e.id).toList());

      // Notification history for this uid (contains summary text with the
      // user's fitness numbers).
      final notifLogs =
          await isar.notificationLogs.filter().uidEqualTo(uid).findAll();
      await isar.notificationLogs
          .deleteAll(notifLogs.map((e) => e.id).toList());

      // Sync-queue items that pointed at the deleted records. Queue items
      // belonging to any other account are left untouched; SyncService
      // already drops them when their target record no longer exists.
      final foodIds = foodLogs.map((e) => e.id).toSet();
      final weightIds = weightLogs.map((e) => e.id).toSet();
      final activityIds = activityLogs.map((e) => e.id).toSet();

      final queueItems = await isar.syncQueueItems.where().findAll();
      final staleQueueIds = <Id>[];
      for (final item in queueItems) {
        final id = item.id;
        if (id == null) continue;
        final matches = switch (item.entity) {
          SyncEntity.food => foodIds.contains(item.localId),
          SyncEntity.weight => weightIds.contains(item.localId),
          SyncEntity.activity => activityIds.contains(item.localId),
        };
        if (matches) staleQueueIds.add(id);
      }
      await isar.syncQueueItems.deleteAll(staleQueueIds);
    });
  }
}
