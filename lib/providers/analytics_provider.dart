import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/date_helper.dart';
import '../data/repositories/food_repository.dart';
import '../data/repositories/weight_activity_repository.dart';
import 'auth_provider.dart';
import 'nutrition_provider.dart';
import 'user_provider.dart';

class InsightMessage {
  final String emoji;
  final String title;
  final String body;
  final InsightType type;

  const InsightMessage({
    required this.emoji,
    required this.title,
    required this.body,
    required this.type,
  });
}

enum InsightType { success, warning, info, danger }

class AnalyticsData {
  final List<InsightMessage> insights;
  final double consistencyScore;         // 0–100
  final List<double> weeklyCalories;     // last 7 days
  final List<double> weeklyWeights;      // last 7 days
  final bool hasPlateauDetected;
  final bool hasLateNightEating;
  final bool hasWeekendSpike;

  // Body Measurements Progress
  final double currentWaist;
  final double initialWaist;
  final double currentNeck;
  final double initialNeck;
  final double currentHip;
  final double initialHip;

  const AnalyticsData({
    this.insights = const [],
    this.consistencyScore = 0,
    this.weeklyCalories = const [],
    this.weeklyWeights = const [],
    this.hasPlateauDetected = false,
    this.hasLateNightEating = false,
    this.hasWeekendSpike = false,
    this.currentWaist = 0.0,
    this.initialWaist = 0.0,
    this.currentNeck = 0.0,
    this.initialNeck = 0.0,
    this.currentHip = 0.0,
    this.initialHip = 0.0,
  });
}

final analyticsProvider = FutureProvider<AnalyticsData>((ref) async {
  final uid = ref.watch(currentUidProvider);
  final foodRepo = ref.watch(foodRepositoryProvider);
  final weightRepo = ref.watch(weightRepositoryProvider);

  final days = DateHelper.last7Days();
  final List<double> weeklyCalories = [];
  int loggedDays = 0;
  bool lateNightEating = false;

  for (final day in days) {
    final logs = await foodRepo.getLogsForDate(uid, day);
    double dayCalories = logs.fold(0.0, (s, l) => s + l.totalCalories);
    weeklyCalories.add(dayCalories);
    if (dayCalories > 0) loggedDays++;
    for (final l in logs) {
      if (DateHelper.isLateNight(l.loggedAt)) lateNightEating = true;
    }
  }

  // Weight trend
  final weightLogs = await weightRepo.getLast7Days(uid);
  final List<double> weeklyWeights = weightLogs.map((w) => w.weight).toList();

  // Plateau detection
  bool plateauDetected = false;
  if (weeklyWeights.length >= 4) {
    final minW = weeklyWeights.reduce((a, b) => a < b ? a : b);
    final maxW = weeklyWeights.reduce((a, b) => a > b ? a : b);
    if ((maxW - minW) < 0.3) plateauDetected = true;
  }

  // Weekend spike
  bool weekendSpike = false;
  if (weeklyCalories.length >= 7) {
    final weekdayAvg = (weeklyCalories.take(5).fold(0.0, (a, b) => a + b)) / 5;
    final weekendAvg = (weeklyCalories.skip(5).fold(0.0, (a, b) => a + b)) / 2;
    if (weekendAvg > weekdayAvg * 1.2) weekendSpike = true;
  }

  final consistency = loggedDays / 7 * 100;
  final nutrition = ref.read(dailyNutritionProvider);

  // --- Advanced Coaching Metrics (Today) ---
  final todayLogs = ref.watch(todayLogsProvider).valueOrNull ?? [];
  
  double liquidCalories = 0;
  int ultraProcessedCount = 0;
  double avgSatiety = 0;
  int satietyCount = 0;

  for (final log in todayLogs) {
    if (log.isLiquid) liquidCalories += log.totalCalories;
    if (log.isUltraProcessed) ultraProcessedCount++;
    if (log.satietyScore > 0) {
      avgSatiety += log.satietyScore;
      satietyCount++;
    }
  }
  
  if (satietyCount > 0) avgSatiety /= satietyCount;
  double liquidCalPct = nutrition.calories > 0 ? (liquidCalories / nutrition.calories) * 100 : 0;

  // Build insights
  final List<InsightMessage> insights = [];

  // 1. Damage Control Mode
  if (nutrition.isOverCalories) {
    insights.add(const InsightMessage(
      emoji: '⚠️',
      title: 'Over Calorie Target',
      body: 'Aap aaj target se upar chale gaye hain, lekin panic na karein! Weekly average abhi bhi recover ho sakta hai. Kal se phir track par aa jayein.',
      type: InsightType.danger,
    ));
  }

  // 2. Protein Deficiency Detection
  if (nutrition.isProteinLow) {
    final missingProtein = (nutrition.proteinTarget - nutrition.protein).toStringAsFixed(0);
    insights.add(InsightMessage(
      emoji: '🥩',
      title: 'Protein Deficiency Warning',
      body: 'Aapka protein target $missingProtein g short hai! Daal, anda, ya chicken add karein warna muscle loss aur hunger bharegi.',
      type: InsightType.warning,
    ));
  }

  // 3. Hunger Prediction System
  if (avgSatiety > 0 && avgSatiety < 5.0 && nutrition.calories > 500) {
    insights.add(const InsightMessage(
      emoji: '🔥',
      title: 'Hunger Prediction',
      body: 'Aapne aaj aisi cheezein khai hain jinka satiety (fullness) score kam hai. Aapko aaglay kuch ghanton mein sakht bhook lag sakti hai. Kuch high-volume salads ya protein lein.',
      type: InsightType.warning,
    ));
  }

  // 4. Liquid Calories Warning
  if (liquidCalPct > 20) {
    insights.add(InsightMessage(
      emoji: '🧃',
      title: 'Hidden Liquid Calories!',
      body: 'Aapki aaj ki total calories ka ${liquidCalPct.toStringAsFixed(0)}% drinks (chai, juice, lassi) se a raha hai. Ye drinks bhook khatam nahi karti aur weight loss rokti hain.',
      type: InsightType.danger,
    ));
  }

  // 5. Ultra Processed Food Tracking
  if (ultraProcessedCount >= 2) {
    insights.add(const InsightMessage(
      emoji: '🍔',
      title: 'High Processed Foods',
      body: 'Aaj aapki diet mein processed ya fast food boht zyada hai. Ye aapka metabolism slow kar sakta hai.',
      type: InsightType.warning,
    ));
  }

  // 6. Weekend Damage Detection
  if (weekendSpike) {
    insights.add(const InsightMessage(
      emoji: '🎉',
      title: 'Weekend Spike Detected',
      body: 'Aapka weekend intake week days ki mehnat ko cancel kar raha hai! Social eating mein portion control zaroori hai.',
      type: InsightType.info,
    ));
  }

  // 7. Satiety/Volume Suggestions
  if (avgSatiety > 0 && avgSatiety < 6.0 && nutrition.fiber < 10) {
    insights.add(const InsightMessage(
      emoji: '🥗',
      title: 'Add High-Volume Foods',
      body: 'Apni diet mein kheera (cucumber), gajar, aur tamatar (tomato) shamil karein. In mein pani zyada aur calories kam hain jo weight loss mein boht help karengy.',
      type: InsightType.info,
    ));
  }

  // 8. General Health / Late Night
  if (lateNightEating) {
    insights.add(const InsightMessage(
      emoji: '🌙',
      title: 'Late Night Eating',
      body: 'Raat dair se khane ki aadat weight loss ko boht slow kar deti hai.',
      type: InsightType.warning,
    ));
  }

  if (plateauDetected && weeklyWeights.isNotEmpty) {
    insights.add(const InsightMessage(
      emoji: '📊',
      title: 'Weight Plateau Detected',
      body: 'Pichle 4 din se wazan nahi gir raha. Pareshan na hon, apni calories ya steps thore barha lein. Water retention bhi ho sakti hai.',
      type: InsightType.info,
    ));
  }

  if (consistency >= 80 && insights.length <= 1) {
    insights.add(const InsightMessage(
      emoji: '🏆',
      title: 'Zabardast Consistency!',
      body: 'Aap pichle hafton mein boht regular rahe hain. Aise hi discipline barqarar rakhein!',
      type: InsightType.success,
    ));
  }

  if (insights.isEmpty) {
    insights.add(const InsightMessage(
      emoji: '✅',
      title: 'Perfect Tracking',
      body: 'Aaj ka din bilkul theek ja raha hai. Excellent job!',
      type: InsightType.success,
    ));
  }

  // Body Measurements Progress
  final logs30 = await weightRepo.getLast30Days(uid);
  final waistLogs = logs30.where((l) => l.waistCm != null).toList();
  final neckLogs = logs30.where((l) => l.neckCm != null).toList();
  final hipLogs = logs30.where((l) => l.hipCm != null).toList();

  final profile = ref.watch(userProfileStreamProvider).valueOrNull;

  double currentWaist = profile?.waistCm ?? 0.0;
  double initialWaist = profile?.waistCm ?? 0.0;
  double currentNeck = profile?.neckCm ?? 0.0;
  double initialNeck = profile?.neckCm ?? 0.0;
  double currentHip = profile?.hipCm ?? 0.0;
  double initialHip = profile?.hipCm ?? 0.0;

  if (waistLogs.isNotEmpty) {
    initialWaist = waistLogs.first.waistCm!;
    currentWaist = waistLogs.last.waistCm!;
  }
  if (neckLogs.isNotEmpty) {
    initialNeck = neckLogs.first.neckCm!;
    currentNeck = neckLogs.last.neckCm!;
  }
  if (hipLogs.isNotEmpty) {
    initialHip = hipLogs.first.hipCm!;
    currentHip = hipLogs.last.hipCm!;
  }

  return AnalyticsData(
    insights: insights,
    consistencyScore: consistency,
    weeklyCalories: weeklyCalories,
    weeklyWeights: weeklyWeights,
    hasPlateauDetected: plateauDetected,
    hasLateNightEating: lateNightEating,
    hasWeekendSpike: weekendSpike,
    currentWaist: currentWaist,
    initialWaist: initialWaist,
    currentNeck: currentNeck,
    initialNeck: initialNeck,
    currentHip: currentHip,
    initialHip: initialHip,
  );
});
