import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_helper.dart';
import '../../data/models/food_log.dart';
import '../../providers/nutrition_provider.dart';
import '../../providers/activity_weight_provider.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/water_provider.dart';
import '../../core/services/network_service.dart';

import '../../providers/notification_provider.dart';
import '../../providers/streak_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileStreamProvider).value;
    final nutrition = ref.watch(dailyNutritionProvider);
    final burnedCalories = ref.watch(todayBurnedCaloriesProvider);
    final stepsAsync = ref.watch(liveStepsProvider);
    final analyticsAsync = ref.watch(analyticsProvider);
    final waterAsync = ref.watch(todayWaterProvider);
    final todayLogs = ref.watch(todayLogsProvider).value ?? [];
    final isOnline = ref.watch(isOnlineProvider).value ?? true;
    final unreadCount = ref.watch(unreadNotificationCountProvider).valueOrNull ?? 0;
    final streakAsync = ref.watch(loggingStreakProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: AppColors.background,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateHelper.greetingMessage(),
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                Text(
                  profile?.name.isNotEmpty == true
                      ? profile!.name
                      : 'Pak Fit Track',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary),
                ),
              ],
            ),
            actions: [
              streakAsync.when(
                data: (streak) {
                  if (streak < 2) return const SizedBox.shrink();
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '🔥 $streak day streak',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              if (!isOnline)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cloud_off_rounded, size: 14, color: AppColors.warning),
                        SizedBox(width: 4),
                        Text('Offline', style: TextStyle(fontSize: 11, color: AppColors.warning, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_outlined,
                        color: AppColors.textSecondary),
                    if (unreadCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            unreadCount > 9 ? '9+' : '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => context.push('/notifications'),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Calorie Summary Card ──────────────────────────────────────
                _CalorieRingCard(nutrition: nutrition, burned: burnedCalories)
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 16),

                // ── Macro Cards ────────────────────────────────────────────
                _MacroRow(nutrition: nutrition)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms),

                const SizedBox(height: 16),

                // ── Steps Card ─────────────────────────────────────────────
                stepsAsync.when(
                  data: (steps) => _StepsCard(
                          steps: steps,
                          goal: profile?.dailyStepEstimate ?? 8000)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 150.ms),
                  loading: () => const _LoadingCard(),
                  error: (_, __) => const _StepsCard(steps: 0, goal: 8000),
                ),

                const SizedBox(height: 16),

                // ── Water Intake Card ──────────────────────────────────────
                waterAsync.when(
                  data: (water) => _WaterIntakeCard(log: water, ref: ref)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 175.ms),
                  loading: () => const _LoadingCard(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                const SizedBox(height: 16),

                // ── Today's food log ───────────────────────────────────────
                _TodayLogCard(logs: todayLogs)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms),

                const SizedBox(height: 16),

                // ── Insight cards ──────────────────────────────────────────
                analyticsAsync.when(
                  data: (data) => _InsightsSection(insights: data.insights)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 250.ms),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ]),
            ),
          ),
        ],
      ),

      // ── FAB: Quick Add Food ────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/food-search'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: const Text('Add Food', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ── Energy Balance Card ─────────────────────────────────────────────────────────
class _CalorieRingCard extends ConsumerWidget {
  final DailyNutrition nutrition;
  final int burned;
  
  const _CalorieRingCard({required this.nutrition, required this.burned});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmr = ref.watch(bmrProvider);
    final stepBurn = ref.watch(stepBurnProvider);
    final exerciseBurn = ref.watch(exerciseBurnProvider);
    final netBalance = ref.watch(netDeficitProvider);
    final totalBurn = bmr + burned; // BMR + active
    
    final double pct = nutrition.calorieTarget > 0
        ? (nutrition.calories / nutrition.calorieTarget).clamp(0.0, 1.0)
        : 0.0;
    final bool isOver = nutrition.calories > nutrition.calorieTarget;
    final color = isOver ? AppColors.error : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        children: [
          // ── Top: Ring + Intake ──────────────────────────────
          Row(
            children: [
              CircularPercentIndicator(
                radius: 62,
                lineWidth: 11,
                percent: pct,
                backgroundColor: AppColors.surfaceLight,
                progressColor: color,
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nutrition.calories.round().toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Text(
                      'eaten',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🍽 Intake header
                    Row(
                      children: [
                        const Text('🍽', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        const Text(
                          'Intake',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _statRow(
                      icon: Icons.restaurant_rounded,
                      label: 'Eaten',
                      value: '${nutrition.calories.round()} kcal',
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 4),
                    _statRow(
                      icon: Icons.flag_rounded,
                      label: 'Target',
                      value: '${nutrition.calorieTarget} kcal',
                      color: AppColors.accent,
                    ),
                    if (isOver) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '⚠️ Over limit!',
                          style: TextStyle(
                              color: AppColors.error,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Divider ────────────────────────────────────────
          Container(
            height: 1,
            color: AppColors.surfaceLight,
          ),

          const SizedBox(height: 14),

          // ── 🔥 Burn Section ────────────────────────────────
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              const Text(
                'Burn',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Total: $totalBurn kcal',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // BMR / Exercise / Steps row
          Row(
            children: [
              Expanded(
                child: _burnChip(
                  icon: Icons.favorite_rounded,
                  label: 'BMR',
                  value: '$bmr kcal',
                  color: const Color(0xFFE57373),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _burnChip(
                  icon: Icons.fitness_center_rounded,
                  label: 'Exercise',
                  value: '$exerciseBurn kcal',
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _burnChip(
                  icon: Icons.directions_walk_rounded,
                  label: 'Steps',
                  value: '$stepBurn kcal',
                  color: AppColors.accent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Divider ────────────────────────────────────────
          Container(
            height: 1,
            color: AppColors.surfaceLight,
          ),

          const SizedBox(height: 12),

          // ── ⚖️ Net Balance ────────────────────────────────
          _netBalanceRow(netBalance),
        ],
      ),
    );
  }

  Widget _burnChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _netBalanceRow(int net) {
    final bool isDeficit = net < 0;
    final bool isSurplus = net > 0;
    final String status;
    final Color statusColor;
    final IconData statusIcon;

    if (isDeficit) {
      status = 'Deficit';
      statusColor = AppColors.success;
      statusIcon = Icons.trending_down_rounded;
    } else if (isSurplus) {
      status = 'Surplus';
      statusColor = AppColors.warning;
      statusIcon = Icons.trending_up_rounded;
    } else {
      status = 'Balanced';
      statusColor = AppColors.accent;
      statusIcon = Icons.horizontal_rule_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Text('⚖️', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          const Text(
            'Net Balance',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Icon(statusIcon, size: 18, color: statusColor),
          const SizedBox(width: 4),
          Text(
            '${net.abs()} kcal',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: AppColors.textMuted)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
      ],
    );
  }
}

// ── Macro Row ─────────────────────────────────────────────────────────────────
class _MacroRow extends StatelessWidget {
  final DailyNutrition nutrition;
  const _MacroRow({required this.nutrition});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MacroCard(
            label: 'Protein',
            value: '${nutrition.protein.round()}g',
            target: '${nutrition.proteinTarget}g',
            percent: nutrition.proteinPct,
            color: AppColors.proteinColor,
            icon: '🥩',
            isLow: nutrition.isProteinLow,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MacroCard(
            label: 'Carbs',
            value: '${nutrition.carbs.round()}g',
            target: '${nutrition.carbsTarget}g',
            percent: nutrition.carbsPct,
            color: AppColors.carbsColor,
            icon: '🍚',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MacroCard(
            label: 'Fat',
            value: '${nutrition.fat.round()}g',
            target: '${nutrition.fatTarget}g',
            percent: nutrition.fatPct,
            color: AppColors.fatColor,
            icon: '🫒',
          ),
        ),
      ],
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String label;
  final String value;
  final String target;
  final double percent;
  final Color color;
  final String icon;
  final bool isLow;

  const _MacroCard({
    required this.label,
    required this.value,
    required this.target,
    required this.percent,
    required this.color,
    required this.icon,
    this.isLow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: isLow
            ? Border.all(color: AppColors.warning.withOpacity(0.5), width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          Text('/ $target',
              style:
                  const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: AppColors.surfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 4,
            ),
          ),
          if (isLow) ...[
            const SizedBox(height: 4),
            const Text('Low!',
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600)),
          ]
        ],
      ),
    );
  }
}

// ── Steps Card ────────────────────────────────────────────────────────────────
class _StepsCard extends StatelessWidget {
  final int steps;
  final int goal;
  const _StepsCard({required this.steps, required this.goal});

  @override
  Widget build(BuildContext context) {
    final pct = goal > 0 ? (steps / goal).clamp(0.0, 1.0) : 0.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.directions_walk_rounded,
                color: AppColors.accent, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      steps.toString(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                    Text(
                      ' / $goal steps',
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: pct,
                    backgroundColor: AppColors.surfaceLight,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.accent),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pct >= 1.0
                      ? '🎉 Daily goal achieved!'
                      : '${((1 - pct) * goal).round()} steps to go',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Water Intake Card ─────────────────────────────────────────────────────────
class _WaterIntakeCard extends StatelessWidget {
  final dynamic log;
  final WidgetRef ref;
  
  const _WaterIntakeCard({required this.log, required this.ref});

  void _showWaterInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.surfaceLight),
          ),
          title: const Row(
            children: [
              Icon(Icons.water_drop_rounded, color: AppColors.info, size: 28),
              SizedBox(width: 10),
              Text(
                'Water & Hydration',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'اردو گائیڈ (Urdu Guide):',
                  style: TextStyle(
                    color: AppColors.info,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '• پانی پینا کیوں ضروری ہے؟\n'
                  'پانی پینے سے آپ کا میٹابولزم 30 فیصد تک تیز ہو جاتا ہے، جو جسم کی چربی کو تیزی سے جلانے میں سیدھی مدد کرتا ہے۔\n\n'
                  '• پانی کی کمی کے کیا نقصانات ہیں؟\n'
                  '1. جھوٹی بھوک: آپ کا دماغ پیاس کو بھوک سمجھ لیتا ہے، جس سے آپ بلاوجہ (جنک فوڈ) کھانے لگتے ہیں۔\n'
                  '2. تھکاوٹ اور سر درد: پانی کی کمی سے خون کا بہاؤ سست ہو جاتا ہے، جس سے آپ کو سستی اور تھکاوٹ محسوس ہوتی ہے۔\n'
                  '3. واٹر ریٹینشن (پیٹ پھولنا): جب آپ کم پانی پیتے ہیں، تو جسم بچاؤ کے لیے پانی جمع کرنے لگتا ہے، جس سے پیٹ پھولا ہوا محسوس ہوتا ہے۔\n\n'
                  '• آپ کو کتنا پانی پینا چاہیے؟\n'
                  'آپ کا روزانہ کا ہدف آپ کے وزن اور جسمانی سرگرمی کے حساب سے بنایا گیا ہے (تقریباً 30 سے 35 ملی لیٹر فی کلو وزن)۔ ورزش کرنے یا گرم موسم میں آپ کو زیادہ پانی پینا چاہیے۔',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                Divider(height: 24, color: AppColors.surfaceLight),
                Text(
                  'English Guide:',
                  style: TextStyle(
                    color: AppColors.info,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '• Why is water important?\n'
                  'Drinking water boosts your metabolism by up to 30%, which directly helps your body burn fat faster.\n\n'
                  '• What happens if you are dehydrated?\n'
                  '1. Fake Hunger: Your brain confuses thirst with hunger, making you crave junk food unnecessarily.\n'
                  '2. Fatigue & Headaches: Low water levels slow down your blood flow, making you feel sluggish and tired.\n'
                  '3. Water Retention: When you don\'t drink enough, your body stores water, causing bloating and weight fluctuations.\n\n'
                  '• How much should you drink?\n'
                  'Your daily goal is customized based on your weight and activity level (approx. 30-35ml per kg of body weight). You should drink more when exercising or in hot weather.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close / بند کریں',
                style: TextStyle(color: AppColors.info, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final glasses = log?.glasses ?? 0;
    final goal = log?.goalGlasses ?? 8;
    final pct = goal > 0 ? (glasses / goal).clamp(0.0, 1.0) : 0.0;

    final String adviceEn;
    final String adviceUr;
    final Color textColor;
    
    // Personalized hydration status based on user's daily target (goalGlasses).
    // Bands:
    // 0–39% → Dehydrated
    // 40–69% → Low Hydration
    // 70–89% → Almost Hydrated
    // 90–100%+ → Fully Hydrated
    final pct100 = (goal > 0) ? (glasses / goal) : 0.0;

    if (glasses <= 0 || pct100 < 0.4) {
      adviceEn =
          "Dehydrated. You're below 40% of your target — drink water to reduce fatigue and fake hunger.";
      adviceUr =
          "Pani ki kami hai. Aap apne target ke 40% se kam par hain — pani piyein taake thakaan aur jhooti bhook kam ho.";
      textColor = AppColors.error;
    } else if (pct100 < 0.7) {
      adviceEn =
          "Low hydration. You're at ${(pct100 * 100).round()}% of your goal — keep sipping consistently.";
      adviceUr =
          "Hydration kam hai. Aap apne target ke ${(pct100 * 100).round()}% par hain — waqfe waqfe se pani peete rahein.";
      textColor = AppColors.warning;
    } else if (pct100 < 0.9) {
      adviceEn =
          "Almost hydrated. ${(pct100 * 100).round()}% done — just a little more to hit your target!";
      adviceUr =
          "Almost complete. ${(pct100 * 100).round()}% ho gaya — bas thora sa aur, target poora ho jayega!";
      textColor = AppColors.accent;
    } else {
      adviceEn =
          "Fully hydrated. Great job hitting your personalized goal — digestion and energy stay strong!";
      adviceUr =
          "Fully hydrated. Aapne apna personal target poora kar liya — energy aur digestion behtar rehte hain!";
      textColor = AppColors.success;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.water_drop_rounded,
                    color: AppColors.info, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Water Intake',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _showWaterInfoDialog(context),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$glasses / $goal glasses',
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(waterNotifierProvider.notifier).addGlass();
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.info.withOpacity(0.1),
                ),
                icon: const Icon(Icons.add_rounded, color: AppColors.info),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppColors.surfaceLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.info),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: textColor.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adviceUr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  adviceEn,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (glasses > 0) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  ref.read(waterNotifierProvider.notifier).removeGlass();
                },
                icon: const Icon(Icons.remove_rounded, size: 16, color: AppColors.error),
                label: const Text(
                  'Remove Glass',
                  style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Today's Log ───────────────────────────────────────────────────────────────
class _TodayLogCard extends ConsumerWidget {
  final List<FoodLog> logs;
  const _TodayLogCard({required this.logs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Today's Food Log",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push('/food-search'),
                child: const Text('+ Add'),
              ),
            ],
          ),
          if (logs.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Column(
                  children: [
                    const Text('🍽️', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text(
                      'No food logged yet today',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            )
          else
            ...logs.take(4).map((log) => _logItem(log, ref)),
          if (logs.length > 4)
            Center(
              child: Text(
                '+${logs.length - 4} more items',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _logItem(FoodLog log, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.restaurant_rounded,
                color: AppColors.textSecondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.foodName ?? 'Unknown Food',
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '${log.quantity.round()}g • ${_mealLabel(log.mealType)}',
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '${log.totalCalories.round()} kcal',
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: AppColors.textMuted, size: 18),
            onPressed: () =>
                ref.read(foodLogNotifierProvider.notifier).deleteLog(log.id),
          ),
        ],
      ),
    );
  }

  String _mealLabel(MealType t) {
    switch (t) {
      case MealType.breakfast: return 'Breakfast';
      case MealType.lunch: return 'Lunch';
      case MealType.dinner: return 'Dinner';
      case MealType.snack: return 'Snack';
    }
  }
}

// ── Insight Cards ─────────────────────────────────────────────────────────────
class _InsightsSection extends StatelessWidget {
  final List<InsightMessage> insights;
  const _InsightsSection({required this.insights});

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Insights',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        ...insights.map((ins) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _InsightCard(insight: ins),
            )),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final InsightMessage insight;
  const _InsightCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    final (bg, border, textColor) = switch (insight.type) {
      InsightType.success => (
          AppColors.success.withOpacity(0.1),
          AppColors.success.withOpacity(0.3),
          AppColors.success,
        ),
      InsightType.warning => (
          AppColors.warning.withOpacity(0.1),
          AppColors.warning.withOpacity(0.3),
          AppColors.warning,
        ),
      InsightType.danger => (
          AppColors.error.withOpacity(0.1),
          AppColors.error.withOpacity(0.3),
          AppColors.error,
        ),
      InsightType.info => (
          AppColors.info.withOpacity(0.1),
          AppColors.info.withOpacity(0.3),
          AppColors.info,
        ),
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Text(insight.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(insight.body,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16)),
      child: const Center(
          child: CircularProgressIndicator(
              color: AppColors.primary, strokeWidth: 2)),
    );
  }
}
