import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';
import '../../core/nutrition/food_behavior_rules.dart';
import '../../data/models/food_item.dart';
import '../../data/models/food_log.dart';
import '../../providers/nutrition_provider.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  final FoodItem food;
  const AddFoodScreen({super.key, required this.food});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  ServingType _servingType = ServingType.gram;
  CookingMethod _cookingMethod = CookingMethod.none;
  MealType _mealType = MealType.lunch;
  double _servingAmount = 1.0;
  double _oilTsp = 0;
  ServingPreset? _selectedPreset;
  static const _kLastPresetKeyPrefix = 'last_preset__';
  static const _kLastPresetAtKeyPrefix = 'last_preset_at__';
  ServingPreset? _recommendedPreset;

  double get _gramsFromServing {
    final preset = _selectedPreset;
    if (preset != null) {
      return _gramsFromPreset(preset);
    }
    switch (_servingType) {
      case ServingType.gram:
        return _servingAmount;
      case ServingType.plate:
        return (widget.food.servingPlate ?? 200) * _servingAmount;
      case ServingType.bowl:
        return (widget.food.servingBowl ?? 150) * _servingAmount;
      case ServingType.piece:
        return (widget.food.servingPiece ?? 90) * _servingAmount;
      case ServingType.cup:
        return (widget.food.servingCup ?? 240) * _servingAmount;
    }
  }

  double get _cookingMultiplier {
    final mutable = widget.food.stateType == FoodStateType.raw ||
        widget.food.stateType == FoodStateType.semiProcessed;
    if (!mutable || !widget.food.supportsCookingMethod) return 1.0;
    switch (_cookingMethod) {
      case CookingMethod.none: return 1.0;
      case CookingMethod.boiled: return widget.food.boiledMultiplier;
      case CookingMethod.grilled: return widget.food.grilledMultiplier;
      case CookingMethod.airFried: return widget.food.airFriedMultiplier;
      case CookingMethod.panFried: return widget.food.panFriedMultiplier;
      case CookingMethod.deepFried: return widget.food.deepFriedMultiplier;
    }
  }

  double get _effectiveOilTsp {
    final mutable = widget.food.stateType == FoodStateType.raw ||
        widget.food.stateType == FoodStateType.semiProcessed;
    return (mutable && widget.food.supportsExtraOil) ? _oilTsp : 0;
  }

  double get _totalCalories {
    final ratio = _gramsFromServing / 100;
    return widget.food.caloriesPer100g * ratio * _cookingMultiplier +
        _effectiveOilTsp * 40;
  }

  double get _totalProtein =>
      widget.food.proteinPer100g * _gramsFromServing / 100;
  double get _totalCarbs =>
      widget.food.carbsPer100g * _gramsFromServing / 100;
  double get _totalFat =>
      widget.food.fatPer100g * _gramsFromServing / 100 +
      _effectiveOilTsp * 4.5;

  @override
  void initState() {
    super.initState();
    // Ensure behavior rules exist even for older seeded DB entries.
    FoodBehaviorRules.applyDefaults(widget.food);

    // Suggest a default meal type based on time (user can always override).
    _mealType = _defaultMealTypeForNow(DateTime.now());

    // Presets: never silently auto-select last used (bias risk).
    // We only *recommend/highlight* last used if it is recent.
    if (widget.food.servingPresets.isNotEmpty &&
        widget.food.inputMode != FoodInputMode.rawOnly) {
      _selectedPreset = widget.food.inputMode == FoodInputMode.presetOnly
          ? widget.food.servingPresets.first
          : null;
      if (_selectedPreset != null) {
        _servingType = _servingTypeFromUnit(_selectedPreset!.unit);
        _servingAmount = _selectedPreset!.quantity;
      }
      _restoreLastPresetRecommendation();
    }

    // Default to a sensible serving (legacy mode only)
    if (widget.food.inputMode != FoodInputMode.presetOnly) {
      final servings = _availableServings();
      _servingType = servings.contains(ServingType.piece)
          ? ServingType.piece
          : servings.contains(ServingType.plate)
              ? ServingType.plate
              : servings.contains(ServingType.bowl)
                  ? ServingType.bowl
                  : ServingType.gram;
      _servingAmount = _servingType == ServingType.gram ? 100 : 1.0;
    }

    // Ensure we don't keep invalid modifiers selected for this food.
    if (!widget.food.supportsCookingMethod) {
      _cookingMethod = CookingMethod.none;
    } else {
      final allowed = _availableCookingMethods();
      if (allowed.isNotEmpty && !allowed.contains(_cookingMethod)) {
        _cookingMethod = allowed.first;
      }
    }
    if (!widget.food.supportsExtraOil) _oilTsp = 0;
  }

  @override
  Widget build(BuildContext context) {
    final logState = ref.watch(foodLogNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.food.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🍽️',
                          style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.food.name,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary)),
                        if (widget.food.nameUrdu.isNotEmpty)
                          Text(widget.food.nameUrdu,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                        Text('per 100g: ${widget.food.caloriesPer100g.round()} kcal',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Serving type ──────────────────────────────────────────────
            if (widget.food.servingPresets.isNotEmpty &&
                widget.food.inputMode != FoodInputMode.rawOnly) ...[
              _sectionLabel('Quick Serving'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.food.servingPresets.map((p) {
                  final selected = identical(_selectedPreset, p);
                  final recommended = identical(_recommendedPreset, p) && !selected;
                  final kcal = _estimatePresetKcal(p);
                  final presetLabel = p.label;
                  return ChoiceChip(
                    label: Text(
                        '$presetLabel${recommended ? ' (recommended)' : ''}${kcal != null ? ' ($kcal kcal)' : ''}'),
                    selected: selected,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() {
                      _selectedPreset = p;
                      _servingType = _servingTypeFromUnit(p.unit);
                      _servingAmount = p.quantity;
                      _persistLastPreset(p);
                    }),
                    labelStyle: TextStyle(
                      color: selected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  );
                }).toList(),
              ),
            ],
            if (widget.food.inputMode == FoodInputMode.flexible) ...[
              const SizedBox(height: 12),
              const Text(
                'Or enter a custom serving below',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
            if (widget.food.inputMode != FoodInputMode.presetOnly) ...[
              _sectionLabel('Serving Type'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: _availableServings().map((st) {
                  return ChoiceChip(
                    label: Text(_servingLabel(st)),
                    selected: _servingType == st,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() {
                      _servingType = st;
                      _servingAmount = st == ServingType.gram ? 100 : 1.0;
                    }),
                    labelStyle: TextStyle(
                      color: _servingType == st
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: _servingType == st
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 16),

            // ── Amount slider ──────────────────────────────────────────────
            if (widget.food.inputMode != FoodInputMode.presetOnly) ...[
              _sectionLabel('Amount'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _servingAmount,
                      min: _servingType == ServingType.gram ? 10 : 0.25,
                      max: _servingType == ServingType.gram ? 500 : 5,
                      divisions: _servingType == ServingType.gram ? 49 : 19,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.surfaceLight,
                      onChanged: (v) => setState(() => _servingAmount = v),
                    ),
                  ),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _servingType == ServingType.gram
                          ? '${_servingAmount.round()}g'
                          : '×${_servingAmount.toStringAsFixed(1)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],

            Text(
              '≈ ${_gramsFromServing.round()}g total',
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 12),
            ),

            const SizedBox(height: 20),

            // ── Cooking method ────────────────────────────────────────────
            if ((widget.food.stateType == FoodStateType.raw ||
                    widget.food.stateType == FoodStateType.semiProcessed) &&
                widget.food.supportsCookingMethod &&
                _availableCookingMethods().isNotEmpty) ...[
              _sectionLabel('Cooking Method'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableCookingMethods().map((cm) {
                  return ChoiceChip(
                    label: Text(_cookingLabel(cm)),
                    selected: _cookingMethod == cm,
                    selectedColor: AppColors.accent.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() => _cookingMethod = cm),
                    labelStyle: TextStyle(
                      color: _cookingMethod == cm
                          ? AppColors.accent
                          : AppColors.textSecondary,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            // ── Oil tracking ───────────────────────────────────────────────
            if ((widget.food.stateType == FoodStateType.raw ||
                    widget.food.stateType == FoodStateType.semiProcessed) &&
                widget.food.supportsExtraOil) ...[
              _sectionLabel('Oil Added (tsp)'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _oilTsp,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      activeColor: AppColors.fatColor,
                      inactiveColor: AppColors.surfaceLight,
                      onChanged: (v) => setState(() => _oilTsp = v),
                    ),
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_oilTsp.toStringAsFixed(1)} tsp',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              if (_oilTsp > 0)
                Text(
                  '+${(_oilTsp * 40).round()} kcal from oil',
                  style: const TextStyle(
                      color: AppColors.fatColor, fontSize: 12),
                ),
              const SizedBox(height: 20),
            ],

            // ── Meal type ──────────────────────────────────────────────────
            _sectionLabel('Meal'),
            const SizedBox(height: 10),
            Row(
              children: MealType.values.map((mt) {
                final selected = _mealType == mt;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _mealType = mt),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(_mealEmoji(mt),
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 4),
                          Text(
                            _mealLabel(mt),
                            style: TextStyle(
                              fontSize: 11,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ── Nutrition summary ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_totalCalories.round()}',
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      const Text(
                        ' kcal',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _macroSummary(
                          'Protein', '${_totalProtein.round()}g', '🥩'),
                      _macroSummary('Carbs', '${_totalCarbs.round()}g', '🍚'),
                      _macroSummary('Fat', '${_totalFat.round()}g', '🫒'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Log button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        color: AppColors.background,
        child: ElevatedButton(
          onPressed: logState.isLoading ? null : _logFood,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
          ),
          child: logState.isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white))
              : const Text('Log Food ✓'),
        ),
      ),
    );
  }

  Future<void> _logFood() async {
    await ref.read(foodLogNotifierProvider.notifier).logFood(
          food: widget.food,
          quantity: _gramsFromServing,
          servingType: _servingType,
          cookingMethod: widget.food.supportsCookingMethod
              ? _cookingMethod
              : CookingMethod.none,
          mealType: _mealType,
          oilTeaspoons: widget.food.supportsExtraOil ? _oilTsp : 0,
          servingAmount: _servingAmount,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ ${widget.food.name} logged!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      context.pop();
      context.pop();
    }
  }

  List<ServingType> _availableServings() {
    final f = widget.food;
    final allowed = f.allowedServingUnits.map((e) => e.toLowerCase()).toList();
    final inferred = <ServingType>[];
    if (f.servingPlate != null) inferred.add(ServingType.plate);
    if (f.servingBowl != null) inferred.add(ServingType.bowl);
    if (f.servingPiece != null) inferred.add(ServingType.piece);
    if (f.servingCup != null) inferred.add(ServingType.cup);

    // If we have explicit allowed units, restrict aggressively.
    // 'grams' maps to ServingType.gram.
    if (allowed.isNotEmpty) {
      final res = <ServingType>[];
      if (allowed.any((u) => u.contains('gram'))) res.add(ServingType.gram);
      if (allowed.any((u) => u.contains('plate'))) res.add(ServingType.plate);
      if (allowed.any((u) => u.contains('bowl'))) res.add(ServingType.bowl);
      if (allowed.any((u) => u.contains('piece'))) res.add(ServingType.piece);
      if (allowed.any((u) => u.contains('cup'))) res.add(ServingType.cup);
      // Only keep types that can actually be converted (except grams).
      return res.where((st) {
        switch (st) {
          case ServingType.gram:
            return true;
          case ServingType.plate:
            return f.servingPlate != null;
          case ServingType.bowl:
            return f.servingBowl != null;
          case ServingType.piece:
            return f.servingPiece != null;
          case ServingType.cup:
            return f.servingCup != null;
        }
      }).toList();
    }

    // No explicit config: fall back to inferred sizes + grams.
    return <ServingType>[ServingType.gram, ...inferred];
  }

  List<CookingMethod> _availableCookingMethods() {
    final allowed = widget.food.allowedCookingMethods
        .map((e) => e.toLowerCase().trim())
        .toList();

    if (!widget.food.supportsCookingMethod) return const [];

    if (allowed.isEmpty) {
      // fallback
      return CookingMethod.values;
    }

    CookingMethod? mapOne(String s) {
      switch (s) {
        case 'as is':
        case 'none':
          return CookingMethod.none;
        case 'boiled':
          return CookingMethod.boiled;
        case 'grilled':
          return CookingMethod.grilled;
        case 'air fried':
        case 'air-fried':
          return CookingMethod.airFried;
        case 'pan fried':
        case 'pan-fried':
          return CookingMethod.panFried;
        case 'deep fried':
        case 'deep-fried':
          return CookingMethod.deepFried;
      }
      return null;
    }

    final res = <CookingMethod>[];
    for (final s in allowed) {
      final cm = mapOne(s);
      if (cm != null && !res.contains(cm)) res.add(cm);
    }
    // Ensure there is always an "As is" option if user wants to log without cooking modifier.
    if (!res.contains(CookingMethod.none)) res.insert(0, CookingMethod.none);
    return res;
  }

  ServingType _servingTypeFromUnit(String unit) {
    switch (unit.toLowerCase().trim()) {
      case 'piece':
        return ServingType.piece;
      case 'plate':
        return ServingType.plate;
      case 'bowl':
        return ServingType.bowl;
      case 'cup':
        return ServingType.cup;
      case 'grams':
      case 'gram':
      default:
        return ServingType.gram;
    }
  }

  double _gramsFromPreset(ServingPreset p) {
    if (p.gramsEquivalent != null && p.gramsEquivalent! > 0) {
      return p.gramsEquivalent!;
    }
    final f = widget.food;
    switch (_servingTypeFromUnit(p.unit)) {
      case ServingType.gram:
        return p.quantity;
      case ServingType.piece:
        return (f.servingPiece ?? 90) * p.quantity;
      case ServingType.plate:
        return (f.servingPlate ?? 200) * p.quantity;
      case ServingType.bowl:
        return (f.servingBowl ?? 150) * p.quantity;
      case ServingType.cup:
        return (f.servingCup ?? 240) * p.quantity;
    }
  }

  int? _estimatePresetKcal(ServingPreset p) {
    // Single authority rule: preset kcal is always computed from gram-equivalent.
    final grams = _gramsFromPreset(p);
    if (grams <= 0) return null;
    final ratio = grams / 100.0;
    final kcal = widget.food.caloriesPer100g * ratio;
    return kcal.isFinite ? kcal.round() : null;
  }

  // (Replaced by _restoreLastPresetRecommendation to avoid silent bias.)

  Future<void> _persistLastPreset(ServingPreset p) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _kLastPresetKeyPrefix + (widget.food.seedId ?? widget.food.id.toString());
      await prefs.setString(key, p.label);
      final atKey = _kLastPresetAtKeyPrefix + (widget.food.seedId ?? widget.food.id.toString());
      await prefs.setInt(atKey, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {}
  }

  Future<void> _restoreLastPresetRecommendation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = (widget.food.seedId ?? widget.food.id.toString());
      final key = _kLastPresetKeyPrefix + id;
      final atKey = _kLastPresetAtKeyPrefix + id;
      final lastLabel = prefs.getString(key);
      final atMs = prefs.getInt(atKey);
      if (lastLabel == null || lastLabel.isEmpty || atMs == null) return;

      // Decay rule: recommendation expires after 3 days.
      final at = DateTime.fromMillisecondsSinceEpoch(atMs);
      if (DateTime.now().difference(at) > const Duration(days: 3)) return;

      final match = widget.food.servingPresets
          .where((p) => p.label == lastLabel)
          .cast<ServingPreset?>()
          .firstWhere((p) => p != null, orElse: () => null);
      if (match == null) return;

      if (!mounted) return;
      setState(() => _recommendedPreset = match);
    } catch (_) {}
  }

  String _servingLabel(ServingType st) {
    switch (st) {
      case ServingType.gram: return 'Grams';
      case ServingType.plate: return 'Plate (${widget.food.servingPlate?.round()}g)';
      case ServingType.bowl: return 'Bowl (${widget.food.servingBowl?.round()}g)';
      case ServingType.piece: return 'Piece (${widget.food.servingPiece?.round()}g)';
      case ServingType.cup: return 'Cup (${widget.food.servingCup?.round()}g)';
    }
  }

  String _cookingLabel(CookingMethod cm) {
    switch (cm) {
      case CookingMethod.none: return 'As is';
      case CookingMethod.boiled: return 'Boiled';
      case CookingMethod.grilled: return 'Grilled';
      case CookingMethod.airFried: return 'Air Fried';
      case CookingMethod.panFried: return 'Pan Fried';
      case CookingMethod.deepFried: return 'Deep Fried';
    }
  }

  String _mealEmoji(MealType mt) {
    switch (mt) {
      case MealType.breakfast: return '🌅';
      case MealType.lunch: return '☀️';
      case MealType.dinner: return '🌙';
      case MealType.snack: return '🍪';
    }
  }

  String _mealLabel(MealType mt) {
    switch (mt) {
      case MealType.breakfast: return 'Breakfast';
      case MealType.lunch: return 'Lunch';
      case MealType.dinner: return 'Dinner';
      case MealType.snack: return 'Snack';
    }
  }

  MealType _defaultMealTypeForNow(DateTime now) {
    final hour = now.hour;
    if (hour >= 5 && hour < 11) {
      return MealType.breakfast;
    } else if (hour >= 11 && hour < 16) {
      return MealType.lunch;
    } else if (hour >= 16 && hour < 20) {
      return MealType.snack;
    } else {
      return MealType.dinner;
    }
  }

  Widget _macroSummary(String label, String value, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5),
    );
  }
}
