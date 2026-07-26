import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _batteryChannel = MethodChannel('pakfittrack/battery');

class BatteryOptimizationService {
  Future<bool?> isIgnoringBatteryOptimizations() async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    try {
      final v = await _batteryChannel.invokeMethod('isIgnoring');
      if (v is bool) return v;
      return v == true;
    } catch (_) {
      return null;
    }
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    try {
      await _batteryChannel.invokeMethod('requestIgnore');
    } catch (_) {}
  }

  Future<void> openBatteryOptimizationSettings() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    try {
      await _batteryChannel.invokeMethod('openSettings');
    } catch (_) {}
  }
}

