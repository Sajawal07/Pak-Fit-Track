import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/local_db/isar_service.dart';
import '../../core/utils/date_helper.dart';
import '../../core/nutrition/food_behavior_rules.dart';
import '../datasources/pk_food_database.dart';
import '../models/food_item.dart';
import '../models/food_log.dart';
import '../../core/services/sync_service.dart';
import '../../data/models/sync_queue_item.dart';
import '../../providers/auth_provider.dart';

enum SearchIntent { family, macro, keyword }

class IntentResolver {
  static SearchIntent detect(String query) {
    final q = query.toLowerCase();
    // Multi-signal fuzzy intent resolution
    if (q.contains('protein') || q.contains('cal') || q.contains('carb') || q.contains('fat')) {
      return SearchIntent.macro;
    }
    
    // Common families in Pakistani diet
    final familyKeywords = [
      'paratha', 'naan', 'roti', 'chicken', 'beef', 'mutton', 'daal', 'dal',
      'rice', 'chawal', 'drink', 'drinks', 'cola', 'coke', 'pepsi', 'sprite',
      'soda', 'juice', 'lassi', 'chai',
    ];
    for (final kw in familyKeywords) {
      if (q.contains(kw)) {
        return SearchIntent.family;
      }
    }
    
    return SearchIntent.keyword;
  }
}

// Simple Levenshtein distance for fuzzy search sorting
int _levenshtein(String a, String b) {
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  List<int> v0 = List<int>.generate(b.length + 1, (i) => i);
  List<int> v1 = List<int>.filled(b.length + 1, 0);
  for (int i = 0; i < a.length; i++) {
    v1[0] = i + 1;
    for (int j = 0; j < b.length; j++) {
      int cost = (a[i] == b[j]) ? 0 : 1;
      v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost].reduce((min, e) => e < min ? e : min);
    }
    for (int j = 0; j <= b.length; j++) {
      v0[j] = v1[j];
    }
  }
  return v1[b.length];
}

class FoodRepository {
  final Isar _db;
  final Ref _ref;
  FoodRepository(this._db, this._ref);

  // ===== FOOD ITEMS =====

  Future<void> seedPakistaniFoods() async {
    final foods = PkFoodDatabase.items;
    for (final f in foods) {
      FoodBehaviorRules.applyDefaults(f);
    }

    await _db.writeTxn(() async {
      for (final f in foods) {
        if (f.seedId != null) {
          final existing =
              await _db.foodItems.filter().seedIdEqualTo(f.seedId!).findFirst();
          if (existing != null) {
            final forceSoftDrinkRefresh = f.family == 'soft_drinks';
            if (f.schemaVersion > existing.schemaVersion ||
                forceSoftDrinkRefresh) {
              f.id = existing.id;
              f.dynamicRank = existing.dynamicRank;
              f.isCustom = existing.isCustom;
              await _db.foodItems.put(f);
            }
          } else {
            await _db.foodItems.put(f);
          }
        } else {
          await _db.foodItems.put(f);
        }
      }
    });
  }

  Future<List<FoodItem>> searchFoods(String query) async {
    if (query.isEmpty) {
      final res = await _db.foodItems.where().limit(50).findAll();
      res.sort((a, b) => b.finalRank.compareTo(a.finalRank));
      return res;
    }
    
    final q = query.toLowerCase().trim();
    final tokens = q.split(' ').where((t) => t.isNotEmpty).toList();
    
    final intent = IntentResolver.detect(q);

    List<FoodItem> results = [];

    if (intent == SearchIntent.macro) {
      // If macro intent, search broad and we will sort by macro density
      results = await _db.foodItems
          .filter()
          .nameContains(q.replaceAll(RegExp(r'protein|cal|carb|fat|calories'), '').trim(), caseSensitive: false)
          .limit(50)
          .findAll();
          
      // Example basic macro sort (could be more advanced based on specific term)
      if (q.contains('protein')) {
        results.sort((a, b) => b.proteinPer100g.compareTo(a.proteinPer100g));
      } else {
         results.sort((a, b) => a.caloriesPer100g.compareTo(b.caloriesPer100g));
      }
      return results;
    }

    // Keyword & Family Intents (Fuzzy search)
    // 1. Exact match or Family match (+ soft drinks family for cola/coke/etc.)
    final drinkQuery = q.contains('drink') ||
        q.contains('cola') ||
        q.contains('coke') ||
        q.contains('cock') ||
        q.contains('pepsi') ||
        q.contains('sprite') ||
        q.contains('suprit') ||
        q.contains('soda') ||
        q.contains('fanta') ||
        q.contains('7up') ||
        q.contains('sting');

    var exactOrFamilyQ = _db.foodItems
        .filter()
        .nameEqualTo(query, caseSensitive: false)
        .or()
        .familyEqualTo(q, caseSensitive: false);
    if (drinkQuery) {
      exactOrFamilyQ = exactOrFamilyQ.or().familyEqualTo('soft_drinks');
    }
    final exactOrFamilyMatches = await exactOrFamilyQ.findAll();

    // 2. Token match & Phonetic match
    final tokenMatches = await _db.foodItems
        .filter()
        .anyOf(tokens, (q, String t) => q.searchTokensElementEqualTo(t))
        .or()
        .anyOf(tokens, (q, String t) => q.phoneticTokensElementEqualTo(t))
        .or()
        .nameContains(q, caseSensitive: false)
        .limit(100)
        .findAll();

    // 3. Combine and Deduplicate
    final seen = <int>{};
    for (final f in exactOrFamilyMatches) {
      if (seen.add(f.id)) results.add(f);
    }
    for (final f in tokenMatches) {
      if (seen.add(f.id)) results.add(f);
    }

    // 4. Deterministic Fuzzy Sort: Exact Name > Edit Distance > Rank
    results.sort((a, b) {
      bool aExactName = a.name.toLowerCase() == q;
      bool bExactName = b.name.toLowerCase() == q;
      if (aExactName && !bExactName) return -1;
      if (!aExactName && bExactName) return 1;

      // Use Levenshtein for robust typo sorting
      int aDist = _levenshtein(q, a.name.toLowerCase());
      int bDist = _levenshtein(q, b.name.toLowerCase());
      
      // If one is significantly closer grammatically
      if ((aDist - bDist).abs() > 2) {
        return aDist.compareTo(bDist);
      }

      // Fallback to our new weighted ranking
      return b.finalRank.compareTo(a.finalRank);
    });

    return results;
  }

  Future<List<FoodItem>> getFoodsByCategory(FoodCategory cat) async {
    return _db.foodItems
        .filter()
        .categoryEqualTo(cat)
        .findAll();
  }

  Future<FoodItem?> getFoodById(int id) async {
    return _db.foodItems.get(id);
  }

  Future<int> saveFood(FoodItem food) async {
    return _db.writeTxn(() async {
      return _db.foodItems.put(food);
    });
  }

  // ===== FOOD LOGS =====

  Future<void> logFood(FoodLog log) async {
    final firebaseUser = _ref.read(authStateProvider).value;
    log.ownerUid = firebaseUser?.uid;
    log.isGuestData = firebaseUser == null;
    await _db.writeTxn(() async {
      await _db.foodLogs.put(log);
    });
    // Enqueue create operation for sync
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.food,
      localId: log.id,
      action: SyncAction.create,
    );
  }

  Future<void> deleteFoodLog(Id id) async {
    final log = await _db.foodLogs.get(id);
    if (log == null) return;
    log.isDeleted = true;
    log.isSynced = false;
    await _db.writeTxn(() async {
      await _db.foodLogs.put(log);
    });
    // Enqueue delete operation for sync
    final syncService = _ref.read(syncServiceProvider);
    await syncService.enqueue(
      entity: SyncEntity.food,
      localId: id,
      action: SyncAction.delete,
    );
  }

  Future<List<FoodLog>> getLogsForDate(String uid, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return _db.foodLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtBetween(start, end)
        .sortByLoggedAt()
        .findAll();
  }

  Stream<List<FoodLog>> watchLogsForToday(String uid) {
    final start = DateHelper.today;
    final end = DateHelper.todayEnd;
    return _db.foodLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtBetween(start, end)
        .watch(fireImmediately: true);
  }

  Future<List<FoodLog>> getLogsForRange(
      String uid, DateTime from, DateTime to) async {
    return _db.foodLogs
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .loggedAtBetween(from, to)
        .sortByLoggedAt()
        .findAll();
  }

  Future<List<FoodLog>> getUnsyncedLogs() async {
    return _db.foodLogs.filter().isSyncedEqualTo(false).findAll();
  }

  Future<void> markLogSynced(Id id, String firebaseId) async {
    final log = await _db.foodLogs.get(id);
    if (log == null) return;
    log.isSynced = true;
    log.firebaseId = firebaseId;
    await _db.writeTxn(() async {
      await _db.foodLogs.put(log);
    });
  }
}

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepository(IsarService.instance, ref);
});
