import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/food_item.dart';
import '../data/models/food_log.dart';
import '../data/repositories/food_repository.dart';
import '../core/utils/date_helper.dart';
import 'auth_provider.dart';
import 'user_provider.dart';
import '../core/services/analytics_service.dart';
import '../core/services/sync_service.dart';

// ── Today's food logs (live stream) ──────────────────────────────────────
final todayLogsProvider = StreamProvider<List<FoodLog>>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(foodRepositoryProvider);
  return repo.watchLogsForToday(uid);
});

// ── Daily nutrition summary ───────────────────────────────────────────────
class DailyNutrition {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final int calorieTarget;
  final int proteinTarget;
  final int carbsTarget;
  final int fatTarget;

  const DailyNutrition({
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.fiber = 0,
    this.calorieTarget = 1800,
    this.proteinTarget = 120,
    this.carbsTarget = 200,
    this.fatTarget = 60,
  });

  double get remainingCalories =>
      (calorieTarget - calories).clamp(0, double.infinity);
  double get caloriePct =>
      calorieTarget > 0 ? (calories / calorieTarget).clamp(0, 1) : 0;
  double get proteinPct =>
      proteinTarget > 0 ? (protein / proteinTarget).clamp(0, 1) : 0;
  double get carbsPct =>
      carbsTarget > 0 ? (carbs / carbsTarget).clamp(0, 1) : 0;
  double get fatPct => fatTarget > 0 ? (fat / fatTarget).clamp(0, 1) : 0;
  bool get isOverCalories => calories > calorieTarget;
  bool get isProteinLow => protein < proteinTarget * 0.5;
}

final dailyNutritionProvider = Provider<DailyNutrition>((ref) {
  final logs = ref.watch(todayLogsProvider).valueOrNull ?? [];
  final profile = ref.watch(userProfileStreamProvider).valueOrNull;

  double cal = 0, pro = 0, carbs = 0, fat = 0, fiber = 0;
  for (final l in logs) {
    cal += l.totalCalories;
    pro += l.totalProtein;
    carbs += l.totalCarbs;
    fat += l.totalFat;
    fiber += l.totalFiber;
  }

  return DailyNutrition(
    calories: cal,
    protein: pro,
    carbs: carbs,
    fat: fat,
    fiber: fiber,
    calorieTarget: profile?.dailyCalorieTarget ?? 1800,
    proteinTarget: profile?.dailyProteinTarget ?? 120,
    carbsTarget: profile?.dailyCarbsTarget ?? 200,
    fatTarget: profile?.dailyFatTarget ?? 60,
  );
});

// ── Food search ───────────────────────────────────────────────────────────
final foodSearchQueryProvider = StateProvider<String>((ref) => '');
final foodSearchCategoryProvider = StateProvider<FoodCategory?>((ref) => null);

final foodSearchResultsProvider = FutureProvider<List<FoodItem>>((ref) async {
  final query = ref.watch(foodSearchQueryProvider);
  final category = ref.watch(foodSearchCategoryProvider);
  final repo = ref.watch(foodRepositoryProvider);
  if (category != null) {
    final foods = await repo.getFoodsByCategory(category);
    foods.sort((a, b) => b.finalRank.compareTo(a.finalRank));
    return foods;
  }
  return repo.searchFoods(query);
});

// ── Log food action ────────────────────────────────────────────────────────
class FoodLogNotifier extends StateNotifier<AsyncValue<void>> {
  final FoodRepository _repo;
  final Ref _ref;

  FoodLogNotifier(this._repo, this._ref) : super(const AsyncValue.data(null));

  Future<void> logFood({
    required FoodItem food,
    required double quantity, // grams
    required ServingType servingType,
    required CookingMethod cookingMethod,
    required MealType mealType,
    double oilTeaspoons = 0,
    required double servingAmount,
  }) async {
    state = const AsyncValue.loading();
    try {
      final uid = _ref.read(currentUidProvider);
      final multiplier = _getCookingMultiplier(food, cookingMethod);
      final oilCalories = oilTeaspoons * 40; // 1 tsp = ~40 kcal

      final ratio = quantity / 100.0;
      final log = FoodLog()
        ..uid = uid
        ..foodItemId = food.id
        ..foodName = food.name
        ..quantity = quantity
        ..servingAmount = servingAmount
        ..servingType = servingType
        ..cookingMethod = cookingMethod
        ..mealType = mealType
        ..oilTeaspoons = oilTeaspoons
        ..totalCalories = (food.caloriesPer100g * ratio * multiplier) + oilCalories
        ..totalProtein = food.proteinPer100g * ratio
        ..totalCarbs = food.carbsPer100g * ratio
        ..totalFat = food.fatPer100g * ratio + (oilTeaspoons * 4.5)
        ..totalFiber = food.fiberPer100g * ratio
        ..totalSugar = food.sugarPer100g * ratio
        ..satietyScore = food.satietyScore
        ..waterPercentage = food.waterPercentage
        ..isLiquid = food.isLiquid
        ..isUltraProcessed = food.isUltraProcessed
        ..loggedAt = DateTime.now()
        ..date = DateHelper.today;

      await _repo.logFood(log);
      try {
        await _ref.read(analyticsServiceProvider).logFoodLogged(mealType.name);
      } catch (_) {}
      
      try {
        _ref.read(syncServiceProvider).requestSync();
      } catch (_) {}
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteLog(int id) async {
    await _repo.deleteFoodLog(id);
    try {
      _ref.read(syncServiceProvider).requestSync();
    } catch (_) {}
  }

  double _getCookingMultiplier(FoodItem food, CookingMethod method) {
    switch (method) {
      case CookingMethod.boiled: return food.boiledMultiplier;
      case CookingMethod.grilled: return food.grilledMultiplier;
      case CookingMethod.airFried: return food.airFriedMultiplier;
      case CookingMethod.panFried: return food.panFriedMultiplier;
      case CookingMethod.deepFried: return food.deepFriedMultiplier;
      case CookingMethod.none: return 1.0;
    }
  }
}

final foodLogNotifierProvider =
    StateNotifierProvider<FoodLogNotifier, AsyncValue<void>>((ref) {
  return FoodLogNotifier(ref.watch(foodRepositoryProvider), ref);
});

// ── Selected date for log browsing ────────────────────────────────────────
final selectedDateProvider = StateProvider<DateTime>((ref) => DateHelper.today);

final selectedDateLogsProvider = FutureProvider<List<FoodLog>>((ref) async {
  final uid = ref.watch(currentUidProvider);
  final date = ref.watch(selectedDateProvider);
  final repo = ref.watch(foodRepositoryProvider);
  return repo.getLogsForDate(uid, date);
});
