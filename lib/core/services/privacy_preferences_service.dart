import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../constants/prefs_keys.dart';

final privacyPreferencesProvider = Provider<PrivacyPreferencesService>((ref) {
  return PrivacyPreferencesService(ref);
});

/// UI state for Analytics toggle.
/// Kept in Riverpod state so the switch updates immediately after user toggles.
final analyticsEnabledProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(PrefsKeys.analyticsEnabled) ?? false;
});

class PrivacyPreferencesService {
  final Ref _ref;
  PrivacyPreferencesService(this._ref);

  bool get isAnalyticsEnabled {
    return _ref.read(analyticsEnabledProvider);
  }

  /// Apply stored preference to Firebase Analytics (call after Firebase init).
  Future<void> applyAnalyticsCollectionSetting() async {
    if (!firebaseAvailable) return;
    try {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
        isAnalyticsEnabled,
      );
    } catch (_) {}
  }

  Future<void> setAnalyticsEnabled(bool enabled) async {
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setBool(PrefsKeys.analyticsEnabled, enabled);
    _ref.read(analyticsEnabledProvider.notifier).state = enabled;
    if (firebaseAvailable) {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled);
    }
  }
}
