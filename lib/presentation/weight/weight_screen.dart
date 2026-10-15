import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_helper.dart';
import '../../core/utils/weight_units.dart';
import '../../providers/activity_weight_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/weight_unit_provider.dart';

class WeightScreen extends ConsumerStatefulWidget {
  const WeightScreen({super.key});

  @override
  ConsumerState<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends ConsumerState<WeightScreen> {
  final _weightCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _waistCtrl = TextEditingController();
  final _neckCtrl = TextEditingController();
  final _hipCtrl = TextEditingController();

  @override
  void dispose() {
    _weightCtrl.dispose();
    _notesCtrl.dispose();
    _waistCtrl.dispose();
    _neckCtrl.dispose();
    _hipCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(weightLogsProvider);
    final latestWeight = ref.watch(latestWeightProvider);
    final progress = ref.watch(weightProgressProvider);
    final profile = ref.watch(userProfileStreamProvider).value;
    final unit = ref.watch(weightUnitProvider);
    final unitLabel = WeightUnits.label(unit);

    // Pre-populate measurements from profile if they are empty
    if (profile != null) {
      if (_waistCtrl.text.isEmpty && profile.waistCm != null) {
        _waistCtrl.text = profile.waistCm!.toString();
      }
      if (_neckCtrl.text.isEmpty && profile.neckCm != null) {
        _neckCtrl.text = profile.neckCm!.toString();
      }
      if (_hipCtrl.text.isEmpty && profile.hipCm != null) {
        _hipCtrl.text = profile.hipCm!.toString();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Weight Tracking'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SegmentedButton<WeightUnit>(
              segments: const [
                ButtonSegment(value: WeightUnit.kg, label: Text('kg')),
                ButtonSegment(value: WeightUnit.lbs, label: Text('lbs')),
              ],
              selected: {unit},
              onSelectionChanged: (s) =>
                  ref.read(weightUnitProvider.notifier).setUnit(s.first),
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Current + Goal ─────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _WeightStatCard(
                    label: 'Current Weight',
                    value: latestWeight != null
                        ? WeightUnits.format(latestWeight, unit)
                        : '— $unitLabel',
                    icon: '⚖️',
                    color: AppColors.primary,
                  ).animate().fadeIn(duration: 400.ms),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _WeightStatCard(
                    label: 'Goal Weight',
                    value: profile?.goalWeight != null
                        ? WeightUnits.format(profile!.goalWeight!, unit)
                        : 'Not set',
                    icon: '🎯',
                    color: AppColors.accent,
                  ).animate().fadeIn(duration: 400.ms, delay: 50.ms),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Progress ───────────────────────────────────────────────
            if (progress != null)
              _ProgressCard(
                      progress: progress, profile: profile, unit: unit)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms),

            const SizedBox(height: 20),

            // ── Log Weight ─────────────────────────────────────────────
            _sectionHeader('Log Today\'s Weight & Measurements', '📝'),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _weightCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Weight ($unitLabel)',
                            prefixIcon:
                                const Icon(Icons.monitor_weight_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _logWeight,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _waistCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Waist (cm)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _neckCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Neck (cm)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _hipCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Hip (cm)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _notesCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      hintText: 'e.g. Morning, after workout...',
                      prefixIcon: Icon(Icons.note_outlined),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Weight Chart ───────────────────────────────────────────
            logsAsync.when(
              data: (logs) {
                if (logs.length < 2) {
                  return Column(
                    children: [
                      _sectionHeader('Weight History', '📊'),
                      const SizedBox(height: 12),
                      _EmptyChartState(),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader('Weight History', '📊'),
                    const SizedBox(height: 12),
                    _WeightChart(logs: logs, unit: unit)
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 150.ms),
                    const SizedBox(height: 20),
                    _sectionHeader('Log History', '📋'),
                    const SizedBox(height: 12),
                    ...logs.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final log = entry.value;
                      final prevLog = idx > 0 ? logs[idx - 1] : null;
                      return _WeightLogTile(
                        log: log,
                        prevLog: prevLog,
                        unit: unit,
                        onDelete: () async {
                          await ref
                              .read(weightNotifierProvider.notifier)
                              .deleteWeight(log.id);
                        },
                      );
                    }).toList().reversed.take(10),
                  ],
                );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary)),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logWeight() async {
    final unit = ref.read(weightUnitProvider);
    final entered = double.tryParse(_weightCtrl.text);
    if (entered == null || entered <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid weight'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final w = WeightUnits.toKg(entered, unit);
    final waist = double.tryParse(_waistCtrl.text);
    final neck = double.tryParse(_neckCtrl.text);
    final hip = double.tryParse(_hipCtrl.text);

    await ref.read(weightNotifierProvider.notifier).logWeight(
          w,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          waistCm: waist,
          neckCm: neck,
          hipCm: hip,
        );

    _weightCtrl.clear();
    _notesCtrl.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Weight and measurements logged!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _sectionHeader(String title, String emoji) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
      ],
    );
  }
}

// ── Weight stat card ──────────────────────────────────────────────────────────
class _WeightStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;

  const _WeightStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

// ── Progress card ─────────────────────────────────────────────────────────────
class _ProgressCard extends StatelessWidget {
  final double progress;
  final dynamic profile;
  final WeightUnit unit;

  const _ProgressCard({
    required this.progress,
    required this.profile,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final lostKg = profile != null
        ? (profile.weight - (profile.goalWeight ?? profile.weight)) as double
        : 0.0;
    final lostDisplay = WeightUnits.toDisplay(lostKg.abs(), unit);
    final unitLabel = WeightUnits.label(unit);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.cardBg,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Goal Progress',
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600)),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.surfaceLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 10,
            ),
          ),
          if (lostKg.abs() > 0) ...[
            const SizedBox(height: 8),
            Text(
              lostKg > 0
                  ? 'Need to lose ${lostDisplay.toStringAsFixed(1)} $unitLabel'
                  : 'Need to gain ${lostDisplay.toStringAsFixed(1)} $unitLabel',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Weight Chart ──────────────────────────────────────────────────────────────
class _WeightChart extends StatelessWidget {
  final List<dynamic> logs;
  final WeightUnit unit;
  const _WeightChart({required this.logs, required this.unit});

  @override
  Widget build(BuildContext context) {
    final unitLabel = WeightUnits.label(unit);
    final spots = logs.asMap().entries.map((e) {
      final kg = e.value.weight as double;
      return FlSpot(e.key.toDouble(), WeightUnits.toDisplay(kg, unit));
    }).toList();

    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 1;
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 1;

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                const FlLine(color: AppColors.surfaceLight, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (v, _) => Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text('${v.round()}$unitLabel',
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 10)),
                ),
              ),
            ),
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

class _WeightLogTile extends StatelessWidget {
  final dynamic log;
  final dynamic prevLog;
  final WeightUnit unit;
  final VoidCallback onDelete;

  const _WeightLogTile({
    required this.log,
    this.prevLog,
    required this.unit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final double? weightDiff = prevLog != null
        ? (log.weight as double) - (prevLog.weight as double)
        : null;
    final unitLabel = WeightUnits.label(unit);

    // Format weight difference
    String weightDiffStr = '';
    Color weightDiffColor = AppColors.textMuted;
    if (weightDiff != null && weightDiff != 0) {
      final sign = weightDiff > 0 ? '+' : '';
      final displayDiff = WeightUnits.toDisplay(weightDiff.abs(), unit);
      weightDiffStr =
          ' ($sign${displayDiff.toStringAsFixed(1)} $unitLabel)';
      weightDiffColor = weightDiff < 0 ? AppColors.success : AppColors.error;
    }

    // Body measurements string & differences
    final measurements = <String>[];
    if (log.waistCm != null) {
      String waistDiffStr = '';
      if (prevLog?.waistCm != null) {
        final diff = (log.waistCm as double) - (prevLog.waistCm as double);
        if (diff != 0) {
          waistDiffStr = ' (${diff > 0 ? '+' : ''}${diff.toStringAsFixed(1)})';
        }
      }
      measurements.add('Waist: ${(log.waistCm as double).toStringAsFixed(1)}cm$waistDiffStr');
    }

    if (log.neckCm != null) {
      String neckDiffStr = '';
      if (prevLog?.neckCm != null) {
        final diff = (log.neckCm as double) - (prevLog.neckCm as double);
        if (diff != 0) {
          neckDiffStr = ' (${diff > 0 ? '+' : ''}${diff.toStringAsFixed(1)})';
        }
      }
      measurements.add('Neck: ${(log.neckCm as double).toStringAsFixed(1)}cm$neckDiffStr');
    }

    if (log.hipCm != null) {
      String hipDiffStr = '';
      if (prevLog?.hipCm != null) {
        final diff = (log.hipCm as double) - (prevLog.hipCm as double);
        if (diff != 0) {
          hipDiffStr = ' (${diff > 0 ? '+' : ''}${diff.toStringAsFixed(1)})';
        }
      }
      measurements.add('Hip: ${(log.hipCm as double).toStringAsFixed(1)}cm$hipDiffStr');
    }

    final hasMeasurements = measurements.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.monitor_weight_outlined,
              color: AppColors.info, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                        WeightUnits.format(log.weight as double, unit),
                        style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    if (weightDiffStr.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(weightDiffStr,
                          style: TextStyle(
                              color: weightDiffColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ],
                  ],
                ),
                if (hasMeasurements) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: measurements.map((m) => Text(
                      m,
                      style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    )).toList(),
                  ),
                ],
                const SizedBox(height: 4),
                Text(DateHelper.formatDate(log.loggedAt as DateTime),
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
          if (log.notes != null && (log.notes as String).isNotEmpty) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(log.notes as String,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 11)),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: AppColors.textMuted, size: 18),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _EmptyChartState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            Text('⚖️', style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text('Log weight for 2+ days to see trend',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
