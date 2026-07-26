import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/notification_log.dart';
import '../data/repositories/notification_repository.dart';
import 'auth_provider.dart';

/// Stream of all notifications for the current user.
final notificationsProvider = StreamProvider<List<NotificationLog>>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.watchNotifications(uid);
});

/// Stream of unread notification count (for badge).
final unreadNotificationCountProvider = StreamProvider<int>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.watchUnreadCount(uid);
});

/// Notifier to perform actions on notifications.
class NotificationActionsNotifier extends StateNotifier<AsyncValue<void>> {
  final NotificationRepository _repo;
  final Ref _ref;

  NotificationActionsNotifier(this._repo, this._ref)
      : super(const AsyncValue.data(null));

  Future<void> markAsRead(int id) async {
    await _repo.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    final uid = _ref.read(currentUidProvider);
    await _repo.markAllAsRead(uid);
  }

  Future<void> deleteNotification(int id) async {
    await _repo.deleteNotification(id);
  }
}

final notificationActionsProvider =
    StateNotifierProvider<NotificationActionsNotifier, AsyncValue<void>>((ref) {
  return NotificationActionsNotifier(
    ref.watch(notificationRepositoryProvider),
    ref,
  );
});
