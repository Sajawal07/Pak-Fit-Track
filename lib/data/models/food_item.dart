import 'package:isar/isar.dart';

part 'food_item.g.dart';

@embedded
class ServingPreset {
  /// What the user taps, e.g. "4 pieces", "Half plate"
  String label = '';

  /// Numeric multiplier or absolute grams depending on [unit].
  /// Examples:
  /// - unit='piece', quantity=4
  /// - unit='plate', quantity=0.5
  /// - unit='grams', quantity=150
  double quantity = 1.0;

  /// One of: grams, piece, plate, bowl, cup
  String unit = 'grams';

  /// Canonical gram-equivalent for this preset, curated or inferred.
  /// If set, calorie math MUST use this as the anchor.
  double? gramsEquivalent;

  @Enumerated(EnumType.name)
  DataConfidence gramsConfidence = DataConfidence.medium;
}

enum DataConfidence {
  high,
  medium,
  low,
}

enum FoodInputMode {
  presetOnly,
  flexible,
  rawOnly,
}

enum FoodCategory {
  bread,
  rice,
  lentils,
  chicken,
  beef,
  mutton,
  fish,
  vegetables,
  dairy,
  snacks,
  fruits,
  beverages,
  desserts,
  oils,
  fastFood,
  other,
}

enum FoodStateType {
  raw,
  semiProcessed,
  cookedFixed,
  composite,
}

@collection
class FoodItem {
  Id id = Isar.autoIncrement;

  String name = '';                 // English name
  String nameUrdu = '';            // Urdu name
  String? brand;
  String? description;

  // Per 100g nutrition values
  double caloriesPer100g = 0;
  double proteinPer100g = 0;
  double carbsPer100g = 0;
  double fatPer100g = 0;
  double fiberPer100g = 0;
  double sugarPer100g = 0;

  // Advanced Coaching Metrics
  double satietyScore = 5.0; // 1-10 scale
  double waterPercentage = 0.0; // 0-100%
  bool isLiquid = false;
  bool isUltraProcessed = false;

  @Enumerated(EnumType.name)
  FoodCategory category = FoodCategory.other;

  // Serving sizes in grams
  double? servingPlate;      // e.g. 200g
  double? servingBowl;       // e.g. 150g
  double? servingPiece;      // e.g. 90g (one roti)
  double? servingCup;        // e.g. 240g

  @Index(unique: true, replace: true)
  String? seedId;

  // Cooking method adjustments (calorie multipliers)
  double boiledMultiplier = 1.0;
  double grilledMultiplier = 1.05;
  double airFriedMultiplier = 1.1;
  double panFriedMultiplier = 1.25;
  double deepFriedMultiplier = 1.5;

  // Smart Search & Architecture
  @Index(type: IndexType.value)
  String? family;
  String type = 'variant';
  List<String> ingredients = [];
  bool supportsCookingMethod = false;

  // Food logging behavior (drives UI + calorie rules)
  @Enumerated(EnumType.name)
  FoodStateType stateType = FoodStateType.raw;
  bool supportsExtraOil = false;
  bool supportsCustomServing = true;

  // If empty, UI will fall back to inferred serving sizes (plate/bowl/piece/cup/grams).
  // Suggested values: 'grams', 'piece', 'half piece', 'plate', 'half plate', 'full plate',
  // 'bowl', 'cup', '4 pieces', '6 pieces'
  List<String> allowedServingUnits = [];

  // If empty, UI will fall back to CookingMethod enum when supportsCookingMethod=true.
  // Suggested values: 'boiled', 'grilled', 'pan fried', 'deep fried', 'air fried', 'as is'
  List<String> allowedCookingMethods = [];

  /// Intelligent one-tap serving presets for fast logging.
  /// If present, UI should prefer these over generic serving selectors/sliders.
  List<ServingPreset> servingPresets = [];

  @Enumerated(EnumType.name)
  FoodInputMode inputMode = FoodInputMode.rawOnly;

  @Index(type: IndexType.hashElements)
  List<String> searchTokens = [];

  @Index(type: IndexType.hashElements)
  List<String> phoneticTokens = []; // Typo variants: 'parata', 'alou'

  // Ranking (separated: seed authority vs user behavior)
  int staticRank = 0;   // Assigned by seed/nutritionist (never changes from analytics)
  int dynamicRank = 0;  // Derived from user log frequency (updated by app)

  @ignore
  int get finalRank => (staticRank * 0.7 + dynamicRank * 1.3).round();

  // Migration safety
  int schemaVersion = 1;

  bool isCustom = false;     // User-added food
  bool isPakistani = true;

  String? firebaseId;        // Firestore document ID

  DateTime createdAt = DateTime.now();
}
