import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/activity_log.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/food_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../data/repositories/weight_activity_repository.dart';
import '../utils/date_helper.dart';
import 'steps_native_store.dart';

/// Authoritative daily metrics for notifications — reads Isar + native store
/// directly instead of live Riverpod UI providers (which are 0/stale in background).
class DailyReportSnapshot {
  final String uid;
  final UserProfile profile;
  final int steps;
  final int stepGoal;
  final int eaten;
  final int calorieTarget;
  final int bmr;
  final int exerciseBurn;
  final int stepsBurn;
  final int totalBurn;
  final int waterGlasses;
  final int waterGoalGlasses;
  final double? latestWeight;
  final double? goalWeight;
  final bool broke7DayRecord;
  final int bestPrev7DaySteps;

  const DailyReportSnapshot({
    required this.uid,
    required this.profile,
    required this.steps,
    required this.stepGoal,
    required this.eaten,
    required this.calorieTarget,
    required this.bmr,
    required this.exerciseBurn,
    required this.stepsBurn,
    required this.totalBurn,
    required this.waterGlasses,
    required this.waterGoalGlasses,
    this.latestWeight,
    this.goalWeight,
    this.broke7DayRecord = false,
    this.bestPrev7DaySteps = 0,
  });

  bool get hasAnyTrackedData =>
      steps > 0 || eaten > 0 || exerciseBurn > 0 || waterGlasses > 0;
}

class DailyReportDataService {
  DailyReportDataService(this._ref);

  final Ref _ref;

  Future<DailyReportSnapshot?> gatherForUid(String uid) async {
    if (uid.isEmpty) return null;

    final userRepo = _ref.read(userRepositoryProvider);
    final profile = await userRepo.getProfile(uid);
    if (profile == null) {
      debugPrint('[DailyReportData] No profile for uid=$uid — skipping');
      return null;
    }

    final today = DateHelper.today;
    final stepGoal = profile.dailyStepEstimate > 0
        ? profile.dailyStepEstimate
        : 8000;
    final calorieTarget =
        profile.dailyCalorieTarget > 0 ? profile.dailyCalorieTarget : 1800;

    var bmr = profile.bmr.round();
    if (bmr <= 0 && profile.weight > 0) {
      if (profile.gender == Gender.male) {
        bmr = (10 * profile.weight +
                6.25 * profile.height -
                5 * profile.age +
                5)
            .round();
      } else {
        bmr = (10 * profile.weight +
                6.25 * profile.height -
                5 * profile.age -
                161)
            .round();
      }
    }

    // Steps: native Room store (Android) → Isar activity log fallback.
    var steps = 0;
    try {
      steps = await NativeStepsStore().getTodaySteps();
    } catch (_) {}
    if (steps <= 0) {
      try {
        final activityRepo = _ref.read(activityRepositoryProvider);
        final logs = await activityRepo.getLogsForDate(uid, today);
        final stepLogs =
            logs.where((l) => l.activityType == ActivityType.steps).toList();
        if (stepLogs.isNotEmpty) {
          stepLogs.sort((a, b) => b.loggedAt.compareTo(a.loggedAt));
          steps = stepLogs.first.steps;
        }
      } catch (_) {}
    }

    // Exercise burn from logged workouts.
    var exerciseBurn = 0;
    try {
      final activityRepo = _ref.read(activityRepositoryProvider);
      final logs = await activityRepo.getLogsForDate(uid, today);
      for (final l in logs) {
        if (l.activityType == ActivityType.workout ||
            l.activityType == ActivityType.cardio) {
          exerciseBurn += l.estimatedCaloriesBurned;
        }
      }
    } catch (_) {}

    final stepsBurn = (steps * 0.04).round().clamp(0, 600);
    final totalBurn = bmr + exerciseBurn + stepsBurn;

    // Eaten calories from food logs.
    var eaten = 0;
    try {
      final foodRepo = _ref.read(foodRepositoryProvider);
      final logs = await foodRepo.getLogsForDate(uid, today);
      eaten = logs.fold<int>(0, (sum, l) => sum + l.totalCalories.round());
    } catch (_) {}

    // Water intake.
    var waterGlasses = 0;
    var waterGoalGlasses = 8;
    try {
      final waterRepo = _ref.read(waterRepositoryProvider);
      final waterLog = await waterRepo.getWaterLog(uid, today);
      if (waterLog != null) {
        waterGlasses = waterLog.glasses;
        waterGoalGlasses =
            waterLog.goalGlasses > 0 ? waterLog.goalGlasses : 8;
      }
    } catch (_) {}

    // Latest weight from logs or profile.
    double? latestWeight;
    try {
      final weightRepo = _ref.read(weightRepositoryProvider);
      final latest = await weightRepo.getLatestWeight(uid);
      latestWeight = latest?.weight ?? (profile.weight > 0 ? profile.weight : null);
    } catch (_) {
      latestWeight = profile.weight > 0 ? profile.weight : null;
    }

    // Weekly step record check.
    var broke7DayRecord = false;
    var bestPrev7DaySteps = 0;
    try {
      final now = DateTime.now();
      final start = now.subtract(const Duration(days: 7));
      String iso(DateTime d) =>
          '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      final range = await NativeStepsStore().getStepsRange(
        startDateIso: iso(start),
        endDateIso: iso(now),
      );
      final todayIso = iso(now);
      for (final e in range.entries) {
        if (e.key == todayIso) continue;
        if (e.value > bestPrev7DaySteps) bestPrev7DaySteps = e.value;
      }
      if (bestPrev7DaySteps > 0 && steps > bestPrev7DaySteps) {
        broke7DayRecord = true;
      }
    } catch (_) {}

    return DailyReportSnapshot(
      uid: uid,
      profile: profile,
      steps: steps,
      stepGoal: stepGoal,
      eaten: eaten,
      calorieTarget: calorieTarget,
      bmr: bmr,
      exerciseBurn: exerciseBurn,
      stepsBurn: stepsBurn,
      totalBurn: totalBurn,
      waterGlasses: waterGlasses,
      waterGoalGlasses: waterGoalGlasses,
      latestWeight: latestWeight,
      goalWeight: profile.goalWeight,
      broke7DayRecord: broke7DayRecord,
      bestPrev7DaySteps: bestPrev7DaySteps,
    );
  }
}

final dailyReportDataServiceProvider = Provider<DailyReportDataService>((ref) {
  return DailyReportDataService(ref);
});
