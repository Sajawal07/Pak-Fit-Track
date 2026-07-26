import 'package:isar/isar.dart';

part 'food_log.g.dart';

enum ServingType { gram, plate, bowl, piece, cup }
enum CookingMethod { none, boiled, grilled, airFried, panFried, deepFried }
enum MealType { breakfast, lunch, dinner, snack }

@collection
class FoodLog {
  Id id = Isar.autoIncrement;

  String uid = '';             // Firebase UID (or 'guest')
  String? ownerUid;            // Firebase UID that owns this record; null = guest-only
  bool isGuestData = false;    // True for guest-only records (never auto-synced)
  int foodItemId = 0;         // Isar local ID of FoodItem
  String? foodName;           // Cached for display

  // Quantity
  double quantity = 100;      // in grams (after conversion)
  double servingAmount = 1.0; // display amount (e.g. 1 plate)

  @Enumerated(EnumType.name)
  ServingType servingType = ServingType.gram;

  @Enumerated(EnumType.name)
  CookingMethod cookingMethod = CookingMethod.none;

  @Enumerated(EnumType.name)
  MealType mealType = MealType.lunch;

  // Extra oil added (in tsps)
  double oilTeaspoons = 0;

  // Calculated nutrition (stored for quick queries)
  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;
  double totalFiber = 0;
  double totalSugar = 0;

  // Cached Advanced Metrics (from FoodItem)
  double satietyScore = 5.0; 
  double waterPercentage = 0.0;
  bool isLiquid = false;
  bool isUltraProcessed = false;

  DateTime loggedAt = DateTime.now();
  DateTime date = DateTime.now(); // date-only for daily queries

  // Sync
  bool isSynced = false;
  String? firebaseId;
  bool isDeleted = false;
}
