import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/weight_log.dart';
import '../data/models/activity_log.dart';
import '../data/models/user_profile.dart';
import '../data/repositories/weight_activity_repository.dart';
import '../data/repositories/user_repository.dart';
import '../core/utils/date_helper.dart';
import 'auth_provider.dart';
import 'user_provider.dart';
import 'nutrition_provider.dart';
import '../core/services/sync_service.dart';
import '../core/services/step_tracker_service.dart';

/// Simple int provider for eaten calories today (used by net deficit calc).
final dailyNutritionCaloriesProvider = Provider<int>((ref) {
  final n = ref.watch(dailyNutritionProvider);
  return n.calories.round();
});

/// Live step count stream — rebuilds UI on every step.
/// Returns 0 when no active user/guest session (e.g. after sign-out).
final liveStepsProvider = StreamProvider<int>((ref) async* {
  final sessionActive = ref.watch(sessionActiveProvider);
  if (!sessionActive) {
    yield 0;
    return;
  }

  final service = ref.watch(stepTrackerServiceProvider);
  yield service.currentSteps;
  yield* service.stepsStream;
});

// ════════════════════════════════════════════════════════
//  WEIGHT PROVIDERS
// ════════════════════════════════════════════════════════

final weightLogsProvider = StreamProvider<List<WeightLog>>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(weightRepositoryProvider);
  return repo.watchWeightLogs(uid);
});

final latestWeightProvider = Provider<double?>((ref) {
  final logs = ref.watch(weightLogsProvider).valueOrNull ?? [];
  if (logs.isEmpty) {
    final profile = ref.watch(userProfileStreamProvider).valueOrNull;
    return profile?.weight;
  }
  final sorted = [...logs]..sort((a, b) => b.loggedAt.compareTo(a.loggedAt));
  return sorted.first.weight;
});

final weightProgressProvider = Provider<double?>((ref) {
  final profile = ref.watch(userProfileStreamProvider).valueOrNull;
  final latest = ref.watch(latestWeightProvider);
  if (profile == null || latest == null) return null;
  if (profile.goalWeight == null) return null;
  final total = profile.weight - profile.goalWeight!;
  if (total == 0) return 1.0;
  final lost = profile.weight - latest;
  return (lost / total).clamp(0.0, 1.0);
});

class WeightNotifier extends StateNotifier<AsyncValue<void>> {
  final WeightRepository _repo;
  final Ref _ref;

  WeightNotifier(this._repo, this._ref) : super(const AsyncValue.data(null));

  Future<void> logWeight(
    double weight, {
    String? notes,
    double? waistCm,
    double? neckCm,
    double? hipCm,
  }) async {
    state = const AsyncValue.loading();
    try {
      final uid = _ref.read(currentUidProvider);
      final log = WeightLog()
        ..uid = uid
        ..weight = weight
        ..notes = notes
        ..waistCm = waistCm
        ..neckCm = neckCm
        ..hipCm = hipCm
        ..loggedAt = DateTime.now()
        ..date = DateHelper.today;
      await _repo.logWeight(log);

      // ALSO update the UserProfile's latest measurements and weight so everything stays in sync!
      try {
        final userRepo = _ref.read(userRepositoryProvider);
        final profile = await userRepo.getProfile(uid);
        if (profile != null) {
          profile.weight = weight;
          if (waistCm != null) profile.waistCm = waistCm;
          if (neckCm != null) profile.neckCm = neckCm;
          if (hipCm != null) profile.hipCm = hipCm;
          profile.updatedAt = DateTime.now();
          await userRepo.saveProfile(profile);
        }
      } catch (_) {}

      try {
        _ref.read(syncServiceProvider).requestSync();
      } catch (_) {}
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteWeight(int id) async {
    await _repo.deleteWeight(id);
    try {
      _ref.read(syncServiceProvider).requestSync();
    } catch (_) {}
  }
}

final weightNotifierProvider =
    StateNotifierProvider<WeightNotifier, AsyncValue<void>>((ref) {
  return WeightNotifier(ref.watch(weightRepositoryProvider), ref);
});

// ════════════════════════════════════════════════════════
//  ACTIVITY PROVIDERS
// ════════════════════════════════════════════════════════

// todayStepsProvider removed — use liveStepsProvider from activity_weight_provider.dart

final todayWorkoutsProvider = FutureProvider<List<ActivityLog>>((ref) async {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(activityRepositoryProvider);
  final logs = await repo.getLogsForDate(uid, DateHelper.today);
  return logs.where((l) => l.activityType == ActivityType.workout).toList();
});

/// BMR from user profile (passive burn — always running).
final bmrProvider = Provider<int>((ref) {
  final profile = ref.watch(userProfileStreamProvider).valueOrNull;
  if (profile == null) return 0;
  // Use stored BMR if already calculated during onboarding
  if (profile.bmr > 0) return profile.bmr.round();
  // Fallback: Mifflin-St Jeor
  if (profile.gender == Gender.male) {
    return (10 * profile.weight + 6.25 * profile.height - 5 * profile.age + 5).round();
  } else {
    return (10 * profile.weight + 6.25 * profile.height - 5 * profile.age - 161).round();
  }
});

/// Calories burned from steps only.
final stepBurnProvider = Provider<int>((ref) {
  final steps = ref.watch(liveStepsProvider).valueOrNull ?? 0;
  // ~0.04 kcal/step, capped (~15k steps) to avoid inflated burn.
  return (steps * 0.04).round().clamp(0, 600);
});

/// Calories burned from logged workouts only.
final exerciseBurnProvider = Provider<int>((ref) {
  final workouts = ref.watch(todayWorkoutsProvider).valueOrNull ?? [];
  int workoutBurn = 0;
  for (final w in workouts) {
    workoutBurn += w.estimatedCaloriesBurned;
  }
  return workoutBurn;
});

/// Active burn = Steps + Exercise (excludes BMR).
final todayBurnedCaloriesProvider = Provider<int>((ref) {
  return ref.watch(stepBurnProvider) + ref.watch(exerciseBurnProvider);
});

/// Net energy balance = Intake − (BMR + Active Burn).
/// Negative = deficit (losing weight), Positive = surplus (gaining weight).
final netDeficitProvider = Provider<int>((ref) {
  final eaten = ref.watch(dailyNutritionCaloriesProvider);
  final bmr = ref.watch(bmrProvider);
  final activeBurn = ref.watch(todayBurnedCaloriesProvider);
  return eaten - (bmr + activeBurn);
});

class ActivityNotifier extends StateNotifier<AsyncValue<void>> {
  final ActivityRepository _repo;
  final Ref _ref;

  ActivityNotifier(this._repo, this._ref) : super(const AsyncValue.data(null));

  Future<void> updateSteps(int steps) async {
    state = const AsyncValue.loading();
    try {
      final uid = _ref.read(currentUidProvider);
      await _repo.updateOrCreateStepLog(uid, steps);
      try {
        _ref.read(syncServiceProvider).requestSync();
      } catch (_) {}
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Persists live pedometer steps into Isar so history is preserved.
  Future<void> saveStepCount(int steps) async {
    try {
      final uid = _ref.read(currentUidProvider);
      await _repo.updateOrCreateStepLog(uid, steps);
    } catch (e) {
      // Non-critical — ignore
    }
  }

  Future<void> logWorkout({
    required String name,
    required int sets,
    required int reps,
    required int durationMinutes,
    required int estimatedBurn,
  }) async {
    state = const AsyncValue.loading();
    try {
      final uid = _ref.read(currentUidProvider);
      final log = ActivityLog()
        ..uid = uid
        ..activityType = ActivityType.workout
        ..workoutName = name
        ..sets = sets
        ..reps = reps
        ..durationMinutes = durationMinutes
        ..estimatedCaloriesBurned = estimatedBurn
        ..loggedAt = DateTime.now()
        ..date = DateHelper.today;
      await _repo.logActivity(log);
      try {
        _ref.read(syncServiceProvider).requestSync();
      } catch (_) {}
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteActivity(int id) async {
    await _repo.deleteActivity(id);
    try {
      _ref.read(syncServiceProvider).requestSync();
    } catch (_) {}
  }
}

final activityNotifierProvider =
    StateNotifierProvider<ActivityNotifier, AsyncValue<void>>((ref) {
  return ActivityNotifier(ref.watch(activityRepositoryProvider), ref);
});
