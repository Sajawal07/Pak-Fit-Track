import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/local_db/isar_service.dart';
import '../models/user_profile.dart';

class UserRepository {
  final Isar _db;
  UserRepository(this._db);

  Future<UserProfile?> getProfile(String uid) async {
    return _db.userProfiles
        .filter()
        .uidEqualTo(uid)
        .findFirst();
  }

  Future<UserProfile?> getAnyProfile() async {
    return _db.userProfiles.where().findFirst();
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _db.writeTxn(() async {
      await _db.userProfiles.put(profile);
    });
  }

  Future<void> deleteProfile(Id id) async {
    await _db.writeTxn(() async {
      await _db.userProfiles.delete(id);
    });
  }

  Stream<UserProfile?> watchProfile(String uid) {
    return _db.userProfiles
        .filter()
        .uidEqualTo(uid)
        .watch(fireImmediately: true)
        .map((list) => list.isNotEmpty ? list.first : null);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(IsarService.instance);
});
