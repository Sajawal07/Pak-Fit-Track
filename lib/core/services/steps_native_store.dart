import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _stepsStoreChannel = MethodChannel('pakfittrack/steps_store');

class NativeStepsStore {
  Future<int> getTodaySteps() async {
    if (defaultTargetPlatform != TargetPlatform.android) return 0;
    final v = await _stepsStoreChannel.invokeMethod('getTodaySteps');
    return (v is int) ? v : int.tryParse('$v') ?? 0;
  }

  /// Returns a map of `yyyy-MM-dd` -> steps.
  Future<Map<String, int>> getStepsRange({
    required String startDateIso,
    required String endDateIso,
  }) async {
    if (defaultTargetPlatform != TargetPlatform.android) return {};
    final v = await _stepsStoreChannel.invokeMethod('getStepsRange', {
      'start': startDateIso,
      'end': endDateIso,
    });
    if (v is Map) {
      return v.map((k, val) => MapEntry('$k', (val is int) ? val : int.tryParse('$val') ?? 0));
    }
    return {};
  }
}

