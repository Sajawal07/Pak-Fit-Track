import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import 'privacy_preferences_service.dart';
import '../../providers/auth_provider.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService(ref);
});

class AnalyticsService {
  final Ref _ref;
  AnalyticsService(this._ref);

  FirebaseAnalytics? get _analytics =>
      firebaseAvailable ? FirebaseAnalytics.instance : null;

  bool get _canLog =>
      firebaseAvailable &&
      _ref.read(analyticsEnabledProvider) &&
      (_ref.read(authStateProvider).value != null);

  Future<void> logAppOpen() async {
    if (!_canLog) return;
    try {
      await _analytics?.logAppOpen();
      await _analytics?.logEvent(name: 'daily_active_user');
    } catch (_) {}
  }

  Future<void> logOnboardingComplete() async {
    if (!_canLog) return;
    try {
      await _analytics?.logEvent(name: 'onboarding_complete');
    } catch (_) {}
  }

  Future<void> logFoodLogged(String mealType) async {
    if (!_canLog) return;
    try {
      await _analytics?.logEvent(
        name: 'food_logged',
        parameters: {'meal_type': mealType},
      );
    } catch (_) {}
  }

  Future<void> logRetentionCheck() async {
    if (!_canLog) return;
    try {
      await _analytics?.logEvent(name: 'retention_check');
    } catch (_) {}
  }
}
