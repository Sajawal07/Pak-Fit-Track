import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/permission_rationale_dialog.dart';

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});

class HealthService {
  final Health _health = Health();

  Future<bool> requestPermissions({BuildContext? context}) async {
    try {
      if (context != null && context.mounted) {
        final prefs = await SharedPreferences.getInstance();
        final shown = prefs.getBool('steps_permission_rationale_shown') ?? false;
        if (!shown) {
          final ok = await showPermissionRationale(
            context,
            title: 'Step tracking',
            message:
                'Pak Fit Track can read your step count from Health Connect or your device sensors to estimate daily activity. You can skip this and log workouts manually.',
            confirmLabel: 'Continue',
          );
          await prefs.setBool('steps_permission_rationale_shown', true);
          if (!ok) return false;
        }
      }

      // For Android 10+, ACTIVITY_RECOGNITION is required for step tracking
      await Permission.activityRecognition.request();

      // Request Health Connect / Google Fit access for steps
      final types = [HealthDataType.STEPS];
      
      final hasPermissions = await _health.hasPermissions(types) ?? false;
      if (!hasPermissions) {
        final success = await _health.requestAuthorization(types);
        return success;
      }
      return true;
    } catch (e) {
      debugPrint('Health Service permission error: $e');
      return false;
    }
  }

  Future<int> getTodaySteps() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      
      final hasPerms = await requestPermissions();
      if (!hasPerms) return 0;

      final steps = await _health.getTotalStepsInInterval(startOfDay, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error getting today steps: $e');
      return 0;
    }
  }

  Future<int> getStepsForDate(DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
      
      final hasPerms = await requestPermissions();
      if (!hasPerms) return 0;

      final steps = await _health.getTotalStepsInInterval(startOfDay, endOfDay);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error getting steps for date $date: $e');
      return 0;
    }
  }
}
