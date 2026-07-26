import 'package:isar/isar.dart';

part 'water_log.g.dart';

@collection
class WaterLog {
  Id id = Isar.autoIncrement;

  String uid = '';
  String? ownerUid;            // Firebase UID that owns this record; null = guest-only
  bool isGuestData = false;    // True for guest-only records (never auto-synced)

  int glasses = 0; // Each glass is assumed to be 250ml
  int goalGlasses = 8; // Default to 8 glasses (2 Liters)

  DateTime date = DateTime.now();
  DateTime updatedAt = DateTime.now();

  bool isSynced = false;
  String? firebaseId;
}
