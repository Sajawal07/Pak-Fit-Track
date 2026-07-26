import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/date_helper.dart';
import '../data/repositories/food_repository.dart';
import 'auth_provider.dart';

/// Consecutive days (including today) with at least one food log.
final loggingStreakProvider = FutureProvider<int>((ref) async {
  final uid = ref.watch(currentUidProvider);
  final foodRepo = ref.watch(foodRepositoryProvider);

  int streak = 0;
  var day = DateHelper.today;

  for (var i = 0; i < 365; i++) {
    final logs = await foodRepo.getLogsForDate(uid, day);
    if (logs.isEmpty) break;
    streak++;
    day = day.subtract(const Duration(days: 1));
  }

  return streak;
});
