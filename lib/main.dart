import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/local_db/isar_service.dart';
import 'data/repositories/food_repository.dart';
import 'core/services/sync_service.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'core/constants/prefs_keys.dart';
import 'core/services/analytics_service.dart';
import 'core/services/step_tracker_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/session_lifecycle_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

/// True only when Firebase.initializeApp() succeeded.
/// Used by providers to safely guard Firebase access.
bool firebaseAvailable = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase — graceful fail if google-services.json or firebase_options.dart not configured yet
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // App Check (Play Integrity). Enforce in Firebase Console → App Check → Firestore.
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
    );

    firebaseAvailable = true;

    // Analytics: disabled in AndroidManifest + Info.plist until we explicitly enable here.
    // Default is OFF (opt-in) — see Profile → Privacy & data.
    final prefs = await SharedPreferences.getInstance();
    final analyticsOn =
        prefs.getBool(PrefsKeys.analyticsEnabled) ?? false;
    await FirebaseAnalytics.instance
        .setAnalyticsCollectionEnabled(analyticsOn);
  } catch (e) {
    debugPrint('Firebase not configured, running in offline mode: $e');
  }

  // Isar local database
  await IsarService.init();

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const _SeedingApp(),
    ),
  );
}

class _SeedingApp extends ConsumerStatefulWidget {
  const _SeedingApp();

  @override
  ConsumerState<_SeedingApp> createState() => _SeedingAppState();
}

class _SeedingAppState extends ConsumerState<_SeedingApp> {
  @override
  void initState() {
    super.initState();
    _seedFoods();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    // Safety net: if auth is somehow already settled at startup (cached session
    // resolved synchronously before build() fires), handle it here.
    // In production Firebase always takes at least one async hop, so this
    // is normally a no-op — the ref.listen in build() handles the real path.
    final currentAuth = ref.read(authStateProvider);
    if (!currentAuth.isLoading) {
      if (currentAuth.valueOrNull != null) {
        ref.read(sessionLifecycleServiceProvider).onSignedIn();
      }
      _maybeStartStepTracker();
    }

    // Initializes notifications; daily report fires after auth bootstrap.
    final notifService = ref.read(notificationServiceProvider);
    await notifService.init();
    if (!mounted) return;

    if (firebaseAvailable) {
      ref.read(syncServiceProvider).startPeriodicSync();
      ref.read(analyticsServiceProvider).logAppOpen();
      ref.read(analyticsServiceProvider).logRetentionCheck();
    }
  }

  /// Starts the step tracker if enabled and a session is active.
  /// StepTrackerService.start() is idempotent (_started guard) — safe to call
  /// from both the build() listener path and the initState safety-net path.
  void _maybeStartStepTracker() {
    final stepTrackingOn = ref
            .read(sharedPreferencesProvider)
            .getBool(PrefsKeys.stepTrackingEnabled) ??
        false;
    if (stepTrackingOn && ref.read(sessionActiveProvider)) {
      ref.read(stepTrackerServiceProvider).start();
    }
  }

  Future<void> _seedFoods() async {
    final repo = ref.read(foodRepositoryProvider);
    await repo.seedPakistaniFoods();
  }

  @override
  Widget build(BuildContext context) {
    // ── ref.listen MUST live in build() ──────────────────────────────────
    // Riverpod 2.x forbids ref.listen in initState, Future.microtask, or
    // any async closure. build() is the only valid location.

    // React to sign-in / sign-out transitions.
    // Catches the normal startup path: Firebase resolves AsyncLoading →
    // AsyncData(user) AFTER the first build(), so this listener always fires.
    ref.listen(authStateProvider, (prev, next) {
      if (next.isLoading) return;
      final prevUser = prev?.valueOrNull;
      final nextUser = next.valueOrNull;
      if (prevUser != null && nextUser == null) {
        ref.read(sessionLifecycleServiceProvider).onSignedOut();
      } else if (prevUser == null && nextUser != null) {
        ref.read(sessionLifecycleServiceProvider).onSignedIn();
      }
    });

    // Start step tracker once auth finishes loading (false → true).
    // This is the primary startup path for step tracking.
    // _maybeStartStepTracker() → start() is idempotent via the _started guard.
    ref.listen<bool>(authBootstrapCompleteProvider, (prev, next) {
      if (next == true && prev != true) _maybeStartStepTracker();
    });

    return const PakFitTrackApp();
  }
}
