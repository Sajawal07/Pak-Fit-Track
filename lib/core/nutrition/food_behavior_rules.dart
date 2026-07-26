import '../../data/models/food_item.dart';

class FoodBehaviorRules {
  FoodBehaviorRules._();

  static void applyDefaults(FoodItem food) {
    food.stateType = _defaultStateType(food);
    food.allowedServingUnits = _defaultServingUnits(food);
    food.allowedCookingMethods = _defaultCookingMethods(food);
    food.servingPresets = _defaultServingPresets(food);
    food.inputMode = _defaultInputMode(food);

    final compositeFixed = _isCompositeFixed(food);
    if (compositeFixed) {
      food.stateType = FoodStateType.composite;
    }

    // Mutable foods only: cooking/oil are only valid for raw/semiProcessed items.
    final mutable = food.stateType == FoodStateType.raw ||
        food.stateType == FoodStateType.semiProcessed;

    food.supportsCookingMethod =
        (mutable && !compositeFixed) ? _defaultSupportsCookingMethod(food) : false;
    food.supportsExtraOil =
        (mutable && !compositeFixed) ? _defaultSupportsExtraOil(food) : false;
    // Custom serving is allowed only when input mode isn't preset-only.
    food.supportsCustomServing = food.inputMode != FoodInputMode.presetOnly;

    if (compositeFixed && food.allowedServingUnits.isEmpty) {
      food.allowedServingUnits = const ['piece', 'half plate', 'full plate', 'bowl'];
    }
  }

  static FoodStateType _defaultStateType(FoodItem food) {
    final n = food.name.toLowerCase();
    final fam = (food.family ?? '').toLowerCase();

    // Egg family: explicitly distinguish raw vs fixed-prep variants.
    if (fam == 'eggs' || n.contains('egg') || n.contains('anda')) {
      if (n.contains('raw')) return FoodStateType.raw;
      // Boiled/fried/omelette are already defined cooking states.
      if (n.contains('boiled') || n.contains('fried') || n.contains('omelette')) {
        return FoodStateType.cookedFixed;
      }
    }

    // Composite families are handled by _isCompositeFixed -> composite.

    return FoodStateType.raw;
  }

  static List<ServingPreset> _defaultServingPresets(FoodItem food) {
    // IMPORTANT: presets are curated per family; do not auto-generate generic presets.
    final n = food.name.toLowerCase();
    final fam = (food.family ?? '').toLowerCase();

    ServingPreset p(
      String label,
      String unit,
      double qty, {
      double? gramsEq,
      DataConfidence confidence = DataConfidence.medium,
    }) {
      return ServingPreset()
        ..label = label
        ..unit = unit
        ..quantity = qty
        ..gramsEquivalent = gramsEq
        ..gramsConfidence = confidence;
    }

    // Paratha family: fixed, simple pieces.
    if (fam == 'paratha' || n.contains('paratha')) {
      return [
        p('1 piece', 'piece', 1, confidence: DataConfidence.medium),
        p('2 pieces', 'piece', 2, confidence: DataConfidence.medium),
      ];
    }

    // Eggs (fixed-prep): pieces only, no cooking/oil modifiers.
    if ((fam == 'eggs' || n.contains('egg') || n.contains('anda')) &&
        (n.contains('boiled') || n.contains('fried') || n.contains('omelette'))) {
      return [
        p('1 egg', 'piece', 1, confidence: DataConfidence.high),
        p('2 eggs', 'piece', 2, confidence: DataConfidence.high),
      ];
    }

    // Biryani family: plates/bowls.
    if (fam == 'biryani' || n.contains('biryani')) {
      return [
        p('Half plate', 'plate', 0.5, confidence: DataConfidence.low),
        p('Full plate', 'plate', 1, confidence: DataConfidence.low),
        p('1 bowl', 'bowl', 1, confidence: DataConfidence.medium),
      ];
    }

    // Nuggets: quick piece presets (common user behavior).
    if (n.contains('nugget') || n.contains('nuggets')) {
      return [
        p('4 pcs', 'piece', 4, confidence: DataConfidence.medium),
        p('6 pcs', 'piece', 6, confidence: DataConfidence.medium),
        p('10 pcs', 'piece', 10, confidence: DataConfidence.medium),
      ];
    }

    // Fries: plate-based presets.
    if (n.contains('fries')) {
      return [
        p('Half plate', 'plate', 0.5, confidence: DataConfidence.low),
        p('Full plate', 'plate', 1, confidence: DataConfidence.low),
      ];
    }

    return const [];
  }

  static FoodInputMode _defaultInputMode(FoodItem food) {
    final n = food.name.toLowerCase();
    final fam = (food.family ?? '').toLowerCase();

    // Composite/cooked-fixed should be preset-only when we have presets.
    if (food.stateType == FoodStateType.composite ||
        food.stateType == FoodStateType.cookedFixed) {
      return food.servingPresets.isNotEmpty
          ? FoodInputMode.presetOnly
          : FoodInputMode.rawOnly;
    }

    // Fast food / snack-like items: preset-only is generally best UX.
    if (n.contains('nugget') || n.contains('nuggets') || n.contains('fries')) {
      return food.servingPresets.isNotEmpty
          ? FoodInputMode.presetOnly
          : FoodInputMode.flexible;
    }

    // Pakistani plate foods (like rice) often need flexible entry in real life.
    if (fam == 'rice' || n.contains('rice')) {
      return food.servingPresets.isNotEmpty
          ? FoodInputMode.flexible
          : FoodInputMode.rawOnly;
    }

    return food.servingPresets.isNotEmpty
        ? FoodInputMode.flexible
        : FoodInputMode.rawOnly;
  }

  static bool _isCompositeFixed(FoodItem food) {
    final n = food.name.toLowerCase();
    final fam = (food.family ?? '').toLowerCase();
    final type = food.type.toLowerCase();

    if (type == 'seed' || type == 'dish') return true;

    const fixedFamilies = {
      'paratha',
      'biryani',
      'nihari',
      'haleem',
      'karahi',
      'qorma',
      'handi',
      'pulao',
      'burger',
      'pizza',
      'samosa',
      'pakora',
      'snacks',
      'desserts',
    };

    if (fixedFamilies.contains(fam)) return true;

    const fixedNameHints = [
      'biryani',
      'nihari',
      'haleem',
      'paratha',
      'samosa',
      'pizza',
      'burger',
      'karahi',
      'qorma',
      'handi',
      'shawarma',
      'wrap',
      'sandwich',
    ];
    if (fixedNameHints.any(n.contains)) return true;

    return false;
  }

  static bool _isFriedFood(FoodItem food) {
    final n = food.name.toLowerCase();
    const hints = [
      'nugget',
      'nuggets',
      'fries',
      'fried chicken',
      'fish fingers',
      'fingers',
      'broast',
    ];
    return hints.any(n.contains);
  }

  static bool _defaultSupportsCookingMethod(FoodItem food) {
    if (_isFriedFood(food)) return true;
    return food.supportsCookingMethod;
  }

  static bool _defaultSupportsExtraOil(FoodItem food) {
    if (_isFriedFood(food)) return true;
    return food.supportsCookingMethod;
  }

  static List<String> _defaultCookingMethods(FoodItem food) {
    if (_isCompositeFixed(food)) return const [];

    if (_isFriedFood(food)) {
      return const ['pan fried', 'deep fried', 'air fried'];
    }

    if (food.supportsCookingMethod) {
      return const ['boiled', 'grilled', 'pan fried', 'deep fried', 'air fried'];
    }

    return const [];
  }

  static List<String> _defaultServingUnits(FoodItem food) {
    final n = food.name.toLowerCase();
    final fam = (food.family ?? '').toLowerCase();

    if (fam == 'paratha' || n.contains('paratha')) {
      return const ['piece', 'half piece'];
    }

    if (fam == 'biryani' || n.contains('biryani')) {
      return const ['plate', 'half plate', 'bowl'];
    }

    if (fam == 'nihari' || n.contains('nihari')) {
      return const ['bowl', 'half bowl'];
    }

    if (n.contains('nugget') || n.contains('nuggets')) {
      return const ['piece', '4 pieces', '6 pieces', 'grams'];
    }

    if (n.contains('fries')) {
      return const ['plate', 'half plate', 'grams'];
    }

    if (_isCompositeFixed(food)) {
      return const ['piece', 'half plate', 'full plate', 'bowl'];
    }

    return const [];
  }
}

