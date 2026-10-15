import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_helper.dart';
import '../../providers/analytics_provider.dart';


class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Analytics')),
      body: analyticsAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (data) => _AnalyticsBody(data: data),
      ),
    );
  }
}

class _AnalyticsBody extends StatelessWidget {
  final AnalyticsData data;
  const _AnalyticsBody({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Consistency Score ─────────────────────────────────────────
          _ConsistencyCard(score: data.consistencyScore)
              .animate()
              .fadeIn(duration: 400.ms),

          const SizedBox(height: 20),

          // ── Weekly Calories Chart ─────────────────────────────────────
          if (data.weeklyCalories.isNotEmpty) ...[
            _sectionTitle('Weekly Calorie Trend', '📊'),
            const SizedBox(height: 12),
            if (data.weeklyCalories.every((c) => c <= 0))
              const _WeeklyCaloriesEmptyState()
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms)
            else
              _WeeklyCaloriesChart(weeklyCalories: data.weeklyCalories)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms),
            const SizedBox(height: 20),
          ],

          // ── Weight Trend ───────────────────────────────────────────────
          if (data.weeklyWeights.isNotEmpty) ...[
            _sectionTitle('Weight Trend', '⚖️'),
            const SizedBox(height: 12),
            _WeightTrendChart(weights: data.weeklyWeights)
                .animate()
                .fadeIn(duration: 400.ms, delay: 150.ms),
            const SizedBox(height: 20),
          ],

          // ── Body Measurements Progress ─────────────────────────────────
          if (data.currentWaist > 0 || data.currentNeck > 0 || data.currentHip > 0) ...[
            _sectionTitle('Body Measurements Progress', '📏'),
            const SizedBox(height: 12),
            _MeasurementsProgressCard(data: data)
                .animate()
                .fadeIn(duration: 400.ms, delay: 180.ms),
            const SizedBox(height: 20),
          ],

          // ── Flags ──────────────────────────────────────────────────────
          _FlagGrid(data: data)
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms),

          const SizedBox(height: 20),

          // ── Insights ──────────────────────────────────────────────────
          _sectionTitle('Smart Insights', '🧠'),
          const SizedBox(height: 12),
          ...data.insights.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _InsightTile(insight: e.value)
                    .animate()
                    .fadeIn(
                        duration: 300.ms,
                        delay: Duration(milliseconds: 250 + e.key * 50))
                    .slideY(begin: 0.2),
              )),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t, String emoji) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(t,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
      ],
    );
  }
}

// ── Consistency Score ─────────────────────────────────────────────────────────
class _ConsistencyCard extends StatelessWidget {
  final double score;
  const _ConsistencyCard({required this.score});

  @override
  Widget build(BuildContext context) {
    final color = score >= 80
        ? AppColors.success
        : score >= 50
            ? AppColors.warning
            : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), AppColors.cardBg],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${score.round()}',
                  style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: color),
                ),
                const Text(
                  'Consistency Score',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  _scoreLabel(score),
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _scoreEmoji(score),
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _scoreLabel(double s) {
    if (s >= 90) return 'Outstanding! Keep it up 🔥';
    if (s >= 70) return 'Very consistent — great job!';
    if (s >= 50) return 'Good progress, stay consistent';
    return 'Track your food every day';
  }

  String _scoreEmoji(double s) {
    if (s >= 90) return '🏆';
    if (s >= 70) return '⭐';
    if (s >= 50) return '👍';
    return '📝';
  }
}

// ── Weekly Calories Chart ─────────────────────────────────────────────────────
class _WeeklyCaloriesEmptyState extends StatelessWidget {
  const _WeeklyCaloriesEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Text('📈', style: TextStyle(fontSize: 40)),
          SizedBox(height: 12),
          Text(
            'Start logging to see your trend',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Meals log karna shuru karein — yahan aapka weekly calorie graph dikhega.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _WeeklyCaloriesChart extends StatelessWidget {
  final List<double> weeklyCalories;
  const _WeeklyCaloriesChart({required this.weeklyCalories});

  @override
  Widget build(BuildContext context) {
    final days = DateHelper.last7Days();
    final spots = weeklyCalories.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => const FlLine(
              color: AppColors.surfaceLight,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  if (i < 0 || i >= days.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      DateHelper.formatShortDate(days[i]),
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 10),
                    ),
                  );
                },
                reservedSize: 28,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Weight Trend Chart ────────────────────────────────────────────────────────
class _WeightTrendChart extends StatelessWidget {
  final List<double> weights;
  const _WeightTrendChart({required this.weights});

  @override
  Widget build(BuildContext context) {
    final spots = weights.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    return Container(
      height: 160,
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                getTitlesWidget: (v, _) => Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text('${v.round()}kg',
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 10)),
                ),
              ),
            ),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.info,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.info.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Flag Grid ─────────────────────────────────────────────────────────────────
class _FlagGrid extends StatelessWidget {
  final AnalyticsData data;
  const _FlagGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final flags = [
      (
        icon: '🌙',
        label: 'Late Night\nEating',
        active: data.hasLateNightEating,
        color: AppColors.warning,
      ),
      (
        icon: '📊',
        label: 'Weight\nPlateau',
        active: data.hasPlateauDetected,
        color: AppColors.info,
      ),
      (
        icon: '🎉',
        label: 'Weekend\nSpike',
        active: data.hasWeekendSpike,
        color: AppColors.accent,
      ),
    ];

    return Row(
      children: flags.map((f) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: f.active
                  ? f.color.withValues(alpha: 0.12)
                  : AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color:
                      f.active ? f.color.withValues(alpha: 0.4) : Colors.transparent),
            ),
            child: Column(
              children: [
                Text(f.icon, style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 6),
                Text(
                  f.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      color:
                          f.active ? f.color : AppColors.textMuted,
                      fontWeight: f.active
                          ? FontWeight.w600
                          : FontWeight.w400),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: f.active
                        ? f.color.withValues(alpha: 0.2)
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    f.active ? 'Detected' : 'Clear',
                    style: TextStyle(
                        fontSize: 10,
                        color:
                            f.active ? f.color : AppColors.textMuted,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Body Measurements Progress Card ──────────────────────────────────────────
class _MeasurementsProgressCard extends StatelessWidget {
  final AnalyticsData data;
  const _MeasurementsProgressCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final rows = <_MeasRow>[];

    if (data.currentWaist > 0) {
      rows.add(_MeasRow(
        label: 'Waist',
        emoji: '📏',
        initial: data.initialWaist,
        current: data.currentWaist,
        lowerIsBetter: true,
      ));
    }
    if (data.currentNeck > 0) {
      rows.add(_MeasRow(
        label: 'Neck',
        emoji: '📿',
        initial: data.initialNeck,
        current: data.currentNeck,
        lowerIsBetter: true,
      ));
    }
    if (data.currentHip > 0) {
      rows.add(_MeasRow(
        label: 'Hip',
        emoji: '🍑',
        initial: data.initialHip,
        current: data.currentHip,
        lowerIsBetter: true,
      ));
    }

    if (rows.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last 30 Days Progress',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ...rows.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildRow(r),
              )),
        ],
      ),
    );
  }

  Widget _buildRow(_MeasRow r) {
    final diff = r.current - r.initial;
    final isImproved = r.lowerIsBetter ? diff < 0 : diff > 0;
    final isNeutral = diff == 0;
    final color = isNeutral
        ? AppColors.textMuted
        : isImproved
            ? AppColors.success
            : AppColors.error;

    final diffStr = diff == 0
        ? 'No change'
        : '${diff > 0 ? '+' : ''}${diff.toStringAsFixed(1)} cm';

    // Progress bar: how much changed relative to starting value
    final pct = r.initial > 0
        ? (diff.abs() / r.initial).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(r.emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              r.label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              '${r.current.toStringAsFixed(1)} cm',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                diffStr,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: AppColors.surfaceLight,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Started: ${r.initial.toStringAsFixed(1)} cm',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _MeasRow {
  final String label;
  final String emoji;
  final double initial;
  final double current;
  final bool lowerIsBetter;

  const _MeasRow({
    required this.label,
    required this.emoji,
    required this.initial,
    required this.current,
    required this.lowerIsBetter,
  });
}

// ── Insight Tile ──────────────────────────────────────────────────────────────
class _InsightTile extends StatelessWidget {
  final InsightMessage insight;
  const _InsightTile({required this.insight});

  @override
  Widget build(BuildContext context) {
    final color = switch (insight.type) {
      InsightType.success => AppColors.success,
      InsightType.warning => AppColors.warning,
      InsightType.danger => AppColors.error,
      InsightType.info => AppColors.info,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Text(insight.emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(insight.body,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
