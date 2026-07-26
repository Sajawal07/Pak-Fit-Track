import 'package:isar/isar.dart';

part 'user_profile.g.dart';

enum UserGoal { lose, maintain, gain }

enum ActivityLevel { sedentary, light, moderate, active }

enum DietPreference {
  normal,
  highProtein,
  lowCarb,
  keto,
  pakistaniTraditional,
  vegetarian,
}

enum Gender { male, female }

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  String uid = '';             // Firebase UID (empty for guest)
  String name = '';
  String email = '';
  bool isGuest = false;

  // Biometrics
  int age = 25;
  double weight = 70.0;       // kg
  double height = 170.0;      // cm
  double? goalWeight;         // target weight in kg

  @Enumerated(EnumType.name)
  Gender gender = Gender.male;

  @Enumerated(EnumType.name)
  UserGoal goal = UserGoal.lose;

  @Enumerated(EnumType.name)
  ActivityLevel activityLevel = ActivityLevel.moderate;

  @Enumerated(EnumType.name)
  DietPreference dietPreference = DietPreference.normal;

  // Lifestyle
  int sleepHours = 7;
  int dailyStepEstimate = 5000;

  // Calculated targets (stored after onboarding)
  int dailyCalorieTarget = 1800;
  int dailyProteinTarget = 120;
  int dailyCarbsTarget = 200;
  int dailyFatTarget = 60;
  double bmr = 0;
  double tdee = 0;

  // Body Measurements
  double? waistCm;
  double? neckCm;
  double? hipCm;

  // Onboarding
  bool onboardingComplete = false;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
