import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../providers/nutrition_provider.dart';
import '../../providers/activity_weight_provider.dart';
import '../../providers/water_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/user_provider.dart';
import '../constants/prefs_keys.dart';
import 'step_tracker_service.dart';
import 'sync_service.dart';

class SessionLifecycleService {
  SessionLifecycleService(this._ref);

  final Ref _ref;

  /// Clears in-memory fitness UI state when the user ends their session.
  Future<void> onSignedOut() async {
    debugPrint('[SessionLifecycle] Tearing down session state');

    // Reset live step stream so dashboards show 0 immediately.
    _ref.read(stepTrackerServiceProvider).resetSession();

    // Stop cloud sync for the previous account.
    try {
      _ref.read(syncServiceProvider).stopPeriodicSync();
    } catch (_) {}

    _invalidateUserScopedProviders();
  }

  /// Restores services after a successful sign-in or guest continuation.
  Future<void> onSignedIn() async {
    debugPrint('[SessionLifecycle] Session established — refreshing providers');

    _invalidateUserScopedProviders();

    try {
      if (firebaseAvailable) {
        _ref.read(syncServiceProvider).startPeriodicSync();
      }
    } catch (_) {}

    final stepTrackingOn = _ref
            .read(sharedPreferencesProvider)
            .getBool(PrefsKeys.stepTrackingEnabled) ??
        false;
    if (stepTrackingOn) {
      await _ref.read(stepTrackerServiceProvider).start();
    }
  }

  void _invalidateUserScopedProviders() {
    _ref.invalidate(userProfileProvider);
    _ref.invalidate(userProfileStreamProvider);
    _ref.invalidate(todayLogsProvider);
    _ref.invalidate(dailyNutritionProvider);
    _ref.invalidate(todayWaterProvider);
    _ref.invalidate(todayWorkoutsProvider);
    _ref.invalidate(weightLogsProvider);
    _ref.invalidate(loggingStreakProvider);
    _ref.invalidate(unreadNotificationCountProvider);
    _ref.invalidate(liveStepsProvider);
  }
}

final sessionLifecycleServiceProvider = Provider<SessionLifecycleService>((ref) {
  return SessionLifecycleService(ref);
});
