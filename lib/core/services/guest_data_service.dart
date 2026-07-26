import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../local_db/isar_service.dart';
import '../constants/prefs_keys.dart';
import '../../providers/auth_provider.dart';
import '../../main.dart';
import '../../data/models/food_log.dart';
import '../../data/models/weight_log.dart';
import '../../data/models/activity_log.dart';
import '../../data/models/water_log.dart';

final guestDataServiceProvider = Provider<GuestDataService>((ref) {
  return GuestDataService(ref, IsarService.instance);
});

class GuestDataService {
  final Ref _ref;
  final Isar _isar;
  GuestDataService(this._ref, this._isar);

  String? get guestUid {
    final prefs = _ref.read(sharedPreferencesProvider);
    return prefs.getString(PrefsKeys.guestUid);
  }

  /// Returns true if there's guest-scoped data on this device.
  Future<bool> hasGuestData() async {
    final g = guestUid;
    if (g == null || g.isEmpty) return false;

    final food = await _isar.foodLogs.filter().uidEqualTo(g).findFirst();
    if (food != null) return true;
    final w = await _isar.weightLogs.filter().uidEqualTo(g).findFirst();
    if (w != null) return true;
    final a = await _isar.activityLogs.filter().uidEqualTo(g).findFirst();
    if (a != null) return true;
    final water = await _isar.waterLogs.filter().uidEqualTo(g).findFirst();
    if (water != null) return true;

    return false;
  }

  /// Imports guest data into the currently signed-in Firebase user.
  /// This is an explicit user action; it does NOT run automatically.
  Future<void> importGuestDataToCurrentUser() async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;
    final firebaseUid = user.uid;
    final g = guestUid;
    if (g == null || g.isEmpty) return;

    await _isar.writeTxn(() async {
      final food = await _isar.foodLogs.filter().uidEqualTo(g).findAll();
      for (final l in food) {
        l
          ..uid = firebaseUid
          ..ownerUid = firebaseUid
          ..isGuestData = false
          ..isSynced = false;
        await _isar.foodLogs.put(l);
      }

      final weights = await _isar.weightLogs.filter().uidEqualTo(g).findAll();
      for (final l in weights) {
        l
          ..uid = firebaseUid
          ..ownerUid = firebaseUid
          ..isGuestData = false
          ..isSynced = false;
        await _isar.weightLogs.put(l);
      }

      final acts = await _isar.activityLogs.filter().uidEqualTo(g).findAll();
      for (final l in acts) {
        l
          ..uid = firebaseUid
          ..ownerUid = firebaseUid
          ..isGuestData = false
          ..isSynced = false;
        await _isar.activityLogs.put(l);
      }

      final waters = await _isar.waterLogs.filter().uidEqualTo(g).findAll();
      for (final l in waters) {
        l
          ..uid = firebaseUid
          ..ownerUid = firebaseUid
          ..isGuestData = false
          ..isSynced = false;
        await _isar.waterLogs.put(l);
      }
    });

    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setString(PrefsKeys.guestImportPromptedForUid, firebaseUid);
  }
}

