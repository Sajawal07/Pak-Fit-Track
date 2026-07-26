import 'package:isar/isar.dart';

part 'weight_log.g.dart';

@collection
class WeightLog {
  Id id = Isar.autoIncrement;

  String uid = '';
  String? ownerUid;            // Firebase UID that owns this record; null = guest-only
  bool isGuestData = false;    // True for guest-only records (never auto-synced)
  double weight = 70.0;       // kg
  double? bodyFatPercent;
  String? notes;

  double? waistCm;
  double? neckCm;
  double? hipCm;

  DateTime loggedAt = DateTime.now();
  DateTime date = DateTime.now(); // date-only for daily queries

  bool isSynced = false;
  String? firebaseId;
  bool isDeleted = false;
}
