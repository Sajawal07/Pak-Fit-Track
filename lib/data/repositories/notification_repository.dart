import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/local_db/isar_service.dart';
import '../models/notification_log.dart';

class NotificationRepository {
  final Isar _isar = IsarService.instance;

  /// Save a notification log to the database.
  Future<void> saveNotification(NotificationLog log) async {
    await _isar.writeTxn(() async {
      await _isar.notificationLogs.put(log);
    });
  }

  /// Get all notifications for a user, most recent first.
  Future<List<NotificationLog>> getNotifications(String uid) async {
    return _isar.notificationLogs
        .filter()
        .uidEqualTo(uid)
        .sortByLoggedAtDesc()
        .findAll();
  }

  /// Watch all notifications as a reactive stream.
  Stream<List<NotificationLog>> watchNotifications(String uid) {
    return _isar.notificationLogs
        .filter()
        .uidEqualTo(uid)
        .sortByLoggedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Get unread count for badge display.
  Future<int> getUnreadCount(String uid) async {
    return _isar.notificationLogs
        .filter()
        .uidEqualTo(uid)
        .isReadEqualTo(false)
        .count();
  }

  /// Watch unread count as a stream for real-time badge updates.
  Stream<int> watchUnreadCount(String uid) {
    return _isar.notificationLogs
        .filter()
        .uidEqualTo(uid)
        .isReadEqualTo(false)
        .watchLazy(fireImmediately: true)
        .asyncMap((_) async {
      return _isar.notificationLogs
          .filter()
          .uidEqualTo(uid)
          .isReadEqualTo(false)
          .count();
    });
  }

  /// Mark a single notification as read.
  Future<void> markAsRead(int id) async {
    await _isar.writeTxn(() async {
      final log = await _isar.notificationLogs.get(id);
      if (log != null) {
        log.isRead = true;
        await _isar.notificationLogs.put(log);
      }
    });
  }

  /// Mark all notifications for a user as read.
  Future<void> markAllAsRead(String uid) async {
    await _isar.writeTxn(() async {
      final logs = await _isar.notificationLogs
          .filter()
          .uidEqualTo(uid)
          .isReadEqualTo(false)
          .findAll();
      for (final log in logs) {
        log.isRead = true;
      }
      await _isar.notificationLogs.putAll(logs);
    });
  }

  /// Delete a notification.
  Future<void> deleteNotification(int id) async {
    await _isar.writeTxn(() async {
      await _isar.notificationLogs.delete(id);
    });
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});
