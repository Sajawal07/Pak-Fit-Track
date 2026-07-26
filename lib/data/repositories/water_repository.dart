import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/water_log.dart';
import '../../core/utils/date_helper.dart';

import '../../core/local_db/isar_service.dart';
import '../../providers/auth_provider.dart';

class WaterRepository {
  final Isar _isar;

  final Ref _ref;
  WaterRepository(this._isar, this._ref);

  Future<WaterLog?> getWaterLog(String uid, DateTime date) async {
    final start = DateHelper.startOfDay(date);
    return await _isar.waterLogs
        .filter()
        .uidEqualTo(uid)
        .dateEqualTo(start)
        .findFirst();
  }

  Stream<WaterLog?> watchWaterLog(String uid, DateTime date) {
    final start = DateHelper.startOfDay(date);
    return _isar.waterLogs
        .filter()
        .uidEqualTo(uid)
        .dateEqualTo(start)
        .watch(fireImmediately: true)
        .map((logs) => logs.isNotEmpty ? logs.first : null);
  }

  Future<void> saveWaterLog(WaterLog log) async {
    final firebaseUser = _ref.read(authStateProvider).value;
    log.ownerUid = firebaseUser?.uid;
    log.isGuestData = firebaseUser == null;
    log.date = DateHelper.startOfDay(log.date);
    log.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.waterLogs.put(log);
    });
  }

  Future<List<WaterLog>> getUnsyncedLogs() async {
    return await _isar.waterLogs.filter().isSyncedEqualTo(false).findAll();
  }
}

final waterRepositoryProvider = Provider<WaterRepository>((ref) {
  return WaterRepository(IsarService.instance, ref);
});
