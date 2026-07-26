import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/user_profile.dart';
import '../../data/models/food_item.dart';
import '../../data/models/food_log.dart';
import '../../data/models/weight_log.dart';
import '../../data/models/activity_log.dart';
import '../../data/models/sync_queue_item.dart';
import '../../data/models/water_log.dart';
import '../../data/models/notification_log.dart';

class IsarService {
  IsarService._();

  static Isar? _isar;

  static Isar get instance {
    if (_isar == null) {
      throw Exception('IsarService not initialized. Call IsarService.init() first.');
    }
    return _isar!;
  }

  static Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        UserProfileSchema,
        FoodItemSchema,
        FoodLogSchema,
        WeightLogSchema,
        ActivityLogSchema,
        SyncQueueItemSchema,
        WaterLogSchema,
        NotificationLogSchema,
      ],
      directory: dir.path,
      name: 'pakfittrack_db',
    );
  }

  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  static Future<void> clearAll() async {
    await _isar?.writeTxn(() async {
      await _isar!.clear();
    });
  }
}
