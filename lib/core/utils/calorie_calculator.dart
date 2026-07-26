class WorkoutCalorieCalculator {
  /// Metabolic Equivalent of Task (MET) values for specific exercises.
  static const Map<String, double> _metValues = {
    // Walking & Running
    'brisk walking': 4.5,
    'hiking': 6.0,
    'jogging': 7.0,
    'sprint running': 14.0,

    // Cycling
    'cycling leisure': 4.0,
    'cycling moderate': 7.5,
    'cycling vigorous': 10.0,
    'mountain biking': 8.5,

    // Gym
    'weight training': 6.0,
    'powerlifting': 8.0,
    'bodybuilding': 5.5,
    'crossfit': 9.0,

    // Bodyweight
    'push ups': 8.0,
    'pull ups': 8.5,
    'squats': 5.0,
    'lunges': 5.0,
    'plank': 3.0,
    'burpees': 10.0,
    'mountain climbers': 8.0,

    // Cardio
    'jump rope': 12.3,
    'jumping jacks': 8.0,
    'hiit': 10.0,
    'aerobics': 7.3,
    'dance fitness': 7.0,

    // Sports
    'football': 8.0,
    'basketball': 8.0,
    'cricket batting': 5.0,
    'cricket bowling': 6.0,
    'tennis': 7.3,
    'badminton': 7.0,
    'volleyball': 4.0,
    'table tennis': 4.0,
    'hockey': 8.0,

    // Water Sports
    'water aerobics': 5.5,
    'rowing': 7.0,

    // Martial Arts
    'boxing': 12.0,
    'karate': 10.0,
    'taekwondo': 10.3,
    'wrestling': 7.0,

    // Yoga & Flexibility
    'power yoga': 4.0,
    'stretching': 2.5,
    'pilates': 3.5,

    // Daily Activities
    'gardening': 4.0,
    'cleaning': 3.5,
    'mopping': 3.8,
    'car washing': 4.5,
    'carrying groceries': 4.0,
    'stair climbing': 8.8,

    // Outdoor Activities
    'rock climbing': 8.0,
    'skating': 7.0,
    'skiing': 7.0,
  };

  /// Calculates estimated calories burned using the MET formula.
  /// Formula: Calories = (MET * Weight in kg * 3.5) / 200 * duration in minutes
  static int calculateBurn(String exerciseName, int durationMinutes, double bodyWeightKg) {
    if (durationMinutes <= 0 || bodyWeightKg <= 0) return 0;

    final query = exerciseName.toLowerCase().trim();
    double met = 5.0; // Fallback: Moderate Workout

    // 1. Exact match check
    if (_metValues.containsKey(query)) {
      met = _metValues[query]!;
    } else {
      // 2. Contains match check (broad categories first, then specifics)
      if (query.contains('run') || query.contains('treadmill')) {
        met = 9.8;
      } else if (query.contains('walk')) {
        met = 3.5;
      } else if (query.contains('cycle') || query.contains('bike') || query.contains('biking')) {
        met = 7.5;
      } else if (query.contains('swim')) {
        met = 8.3;
      } else if (query.contains('yoga')) {
        met = 3.0;
      } else {
        // 3. Fallback contains match from the detailed map
        for (final key in _metValues.keys) {
          if (query.contains(key) || key.contains(query)) {
            met = _metValues[key]!;
            break;
          }
        }
      }
    }

    final double burnPerMinute = (met * bodyWeightKg * 3.5) / 200.0;
    final raw = (burnPerMinute * durationMinutes).round();
    // Cap per session to reduce over-estimation distrust (≈2h intense cardio).
    return raw.clamp(0, 1200);
  }
}
