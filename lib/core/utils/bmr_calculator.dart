/// BMR/TDEE calculations using Mifflin-St Jeor equation
class BmrCalculator {
  BmrCalculator._();

  /// Calculate BMR using Mifflin-St Jeor equation
  /// [weight] in kg, [height] in cm, [age] in years
  static double calculateBMR({
    required double weight,
    required double height,
    required int age,
    required String gender, // 'male' or 'female'
  }) {
    final base = (10 * weight) + (6.25 * height) - (5 * age);
    return gender.toLowerCase() == 'male' ? base + 5 : base - 161;
  }

  /// Activity multipliers
  static const Map<String, double> activityMultipliers = {
    'sedentary': 1.2,
    'light': 1.375,
    'moderate': 1.55,
    'active': 1.725,
  };

  static String activityLabel(String level) {
    switch (level) {
      case 'sedentary':
        return 'Sedentary (no exercise)';
      case 'light':
        return 'Light (1-3 days/week)';
      case 'moderate':
        return 'Moderate (3-5 days/week)';
      case 'active':
        return 'Active (daily exercise)';
      default:
        return 'Moderate';
    }
  }

  /// Calculate TDEE
  static double calculateTDEE({
    required double bmr,
    required String activityLevel,
  }) {
    final multiplier = activityMultipliers[activityLevel] ?? 1.55;
    return bmr * multiplier;
  }

  /// Calculate daily calorie target based on goal
  static int calculateCalorieTarget({
    required double tdee,
    required String goal, // 'lose', 'maintain', 'gain'
  }) {
    switch (goal) {
      case 'lose':
        return (tdee - 500).round().clamp(1200, 99999);
      case 'gain':
        return (tdee + 300).round();
      case 'maintain':
      default:
        return tdee.round();
    }
  }

  /// Calculate protein target in grams
  static int calculateProteinTarget({
    required double weight, // kg
    required String goal,
    required String activityLevel,
  }) {
    double multiplier;
    if (goal == 'gain') {
      multiplier = 2.2;
    } else if (activityLevel == 'active' || activityLevel == 'moderate') {
      multiplier = 1.8;
    } else if (goal == 'lose') {
      multiplier = 1.6;
    } else {
      multiplier = 1.2;
    }
    return (weight * multiplier).round();
  }

  /// Calculate carbs target in grams
  static int calculateCarbsTarget({
    required int calorieTarget,
    required int proteinGrams,
    required int fatGrams,
    required String dietPreference,
  }) {
    if (dietPreference == 'keto') return 25;
    if (dietPreference == 'low_carb') {
      return ((calorieTarget - (proteinGrams * 4) - (fatGrams * 9)) / 4)
          .round()
          .clamp(50, 150);
    }
    // Standard: ~45% of calories from carbs
    return ((calorieTarget * 0.45) / 4).round();
  }

  /// Calculate fat target in grams
  static int calculateFatTarget({
    required int calorieTarget,
    required String dietPreference,
  }) {
    if (dietPreference == 'keto') {
      // 70% from fat
      return ((calorieTarget * 0.70) / 9).round();
    }
    // Standard: ~30% from fat
    return ((calorieTarget * 0.30) / 9).round();
  }

  /// Calculate BMI
  static double calculateBMI({
    required double weight, // kg
    required double height, // cm
  }) {
    final heightM = height / 100;
    return weight / (heightM * heightM);
  }

  static String bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  /// Weeks to reach goal weight
  static int weeksToGoal({
    required double currentWeight,
    required double goalWeight,
    required int dailyDeficit,
  }) {
    final kgToLose = (currentWeight - goalWeight).abs();
    if (dailyDeficit <= 0) return 0;
    final weeklyLoss = (dailyDeficit * 7) / 7700; // ~7700 kcal per kg
    if (weeklyLoss <= 0) return 0;
    return (kgToLose / weeklyLoss).ceil();
  }
}
