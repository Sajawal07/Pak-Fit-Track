import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/prefs_keys.dart';

/// Android native foreground service integration.
/// Live steps come from native TYPE_STEP_COUNTER in a foreground service.
/// Native Android layer is authoritative for persistence (Room).
const _channel = MethodChannel('pakfittrack/steps');
const _events = EventChannel('pakfittrack/steps_events');

class StepTrackerService {
  StepTrackerService();

  final _stepsController = StreamController<int>.broadcast();
  StreamSubscription<dynamic>? _nativeSub;
  int _todaySteps = 0;
  bool _started = false;

  Stream<int> get stepsStream => _stepsController.stream;
  int get currentSteps => _todaySteps;

  /// SINGLE SOURCE OF TRUTH: Call ONLY from app startup (main.dart).
  /// UI/providers must never trigger lifecycle.
  Future<void> start() async {
    if (_started) return;
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(PrefsKeys.stepTrackingEnabled) ?? false;
    if (!enabled) return;
    _started = true;

    // Permissions needed for step sensor + Health Connect.
    await Permission.activityRecognition.request();
    await Permission.sensors.request();

    // Start native foreground service for live steps (best-effort on iOS: no-op).
    await _startNativeForegroundService();

    // Subscribe to native live steps stream exactly once.
    _nativeSub?.cancel();
    _nativeSub = _events.receiveBroadcastStream().listen(
      (dynamic event) {
        final steps = (event is int) ? event : int.tryParse('$event') ?? 0;
        _onLiveSteps(steps);
      },
      onError: (e) => debugPrint('[StepTracker] native stream error: $e'),
      cancelOnError: false,
    );
  }

  Future<void> _onLiveSteps(int steps) async {
    _todaySteps = steps.clamp(0, 999999);
    _stepsController.add(_todaySteps);
  }

  Future<void> _startNativeForegroundService() async {
    try {
      if (defaultTargetPlatform != TargetPlatform.android) return;
      await _channel.invokeMethod('start');
    } catch (e) {
      debugPrint('[StepTracker] native start failed: $e');
    }
  }

  Future<void> stop() async {
    _started = false; // Allow start() to re-run after a stop.
    try {
      if (defaultTargetPlatform != TargetPlatform.android) return;
      await _channel.invokeMethod('stop');
    } catch (e) {
      debugPrint('[StepTracker] native stop failed: $e');
    }
  }

  /// Clears in-memory step count for the current UI session (e.g. on sign-out).
  void resetSession() {
    _todaySteps = 0;
    if (!_stepsController.isClosed) {
      _stepsController.add(0);
    }
  }

  void dispose() {
    _nativeSub?.cancel();
    _stepsController.close();
  }
}

// ── Riverpod providers ──────────────────────────────────────────────────────

final stepTrackerServiceProvider = Provider<StepTrackerService>((ref) {
  final service = StepTrackerService();
  ref.onDispose(service.dispose);
  return service;
});
