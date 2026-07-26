import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/water_log.dart';
import '../data/models/user_profile.dart';
import '../data/repositories/water_repository.dart';
import 'auth_provider.dart';
import 'user_provider.dart';
import '../core/utils/date_helper.dart';

final dailyWaterGoalProvider = Provider<int>((ref) {
  final profile = ref.watch(userProfileStreamProvider).valueOrNull;
  if (profile == null || profile.weight <= 0) return 8; // fallback

  // Base water: 33 ml per kg of body weight
  double baseMl = profile.weight * 33.0;

  // Adjust for activity level
  switch (profile.activityLevel) {
    case ActivityLevel.sedentary:
      break;
    case ActivityLevel.light:
      baseMl += 250; // +1 glass
      break;
    case ActivityLevel.moderate:
      baseMl += 500; // +2 glasses
      break;
    case ActivityLevel.active:
      baseMl += 750; // +3 glasses
      break;
  }

  // Convert to glasses (250ml per glass) and round
  return (baseMl / 250.0).round();
});

final todayWaterProvider = StreamProvider<WaterLog?>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(waterRepositoryProvider);
  return repo.watchWaterLog(uid, DateHelper.today);
});

class WaterNotifier extends StateNotifier<AsyncValue<void>> {
  final WaterRepository _repo;
  final Ref _ref;

  WaterNotifier(this._repo, this._ref) : super(const AsyncValue.data(null));

  Future<void> addGlass() async {
    await _updateGlasses(1);
  }

  Future<void> removeGlass() async {
    await _updateGlasses(-1);
  }

  Future<void> _updateGlasses(int change) async {
    try {
      final uid = _ref.read(currentUidProvider);
      final existing = await _repo.getWaterLog(uid, DateHelper.today);
      
      final dynamicGoal = _ref.read(dailyWaterGoalProvider);

      final log = existing ?? WaterLog()
        ..uid = uid
        ..date = DateHelper.startOfDay(DateHelper.today)
        ..goalGlasses = dynamicGoal;
        
      log.glasses = (log.glasses + change).clamp(0, 99);
      log.goalGlasses = dynamicGoal; // Keep goal synced with current profile
      
      await _repo.saveWaterLog(log);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final waterNotifierProvider = StateNotifierProvider<WaterNotifier, AsyncValue<void>>((ref) {
  return WaterNotifier(ref.watch(waterRepositoryProvider), ref);
});
