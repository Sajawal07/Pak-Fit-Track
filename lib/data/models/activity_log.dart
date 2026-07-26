import 'package:isar/isar.dart';

part 'activity_log.g.dart';

enum ActivityType { steps, workout, cardio }

@collection
class ActivityLog {
  Id id = Isar.autoIncrement;

  String uid = '';
  String? ownerUid;            // Firebase UID that owns this record; null = guest-only
  bool isGuestData = false;    // True for guest-only records (never auto-synced)

  @Enumerated(EnumType.name)
  ActivityType activityType = ActivityType.steps;

  // Steps
  int steps = 0;
  int stepGoal = 8000;

  // Workout
  String? workoutName;      // e.g. "Push-ups", "Running"
  int sets = 0;
  int reps = 0;
  int durationMinutes = 0;
  int estimatedCaloriesBurned = 0;

  String? notes;

  DateTime loggedAt = DateTime.now();
  DateTime date = DateTime.now();

  bool isSynced = false;
  String? firebaseId;
  bool isDeleted = false;
}
