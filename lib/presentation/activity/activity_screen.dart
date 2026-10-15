import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/activity_weight_provider.dart';
import '../../core/utils/calorie_calculator.dart';
import '../../providers/user_provider.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  final _workoutNameCtrl = TextEditingController();
  final _setsCtrl = TextEditingController(text: '3');
  final _repsCtrl = TextEditingController(text: '12');
  final _durationCtrl = TextEditingController(text: '30');

  @override
  void initState() {
    super.initState();
    // Step tracking lifecycle is controlled centrally from app startup (main.dart).
  }

  @override
  void dispose() {
    _workoutNameCtrl.dispose();
    _setsCtrl.dispose();
    _repsCtrl.dispose();
    _durationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stepsAsync = ref.watch(liveStepsProvider);
    final workoutsAsync = ref.watch(todayWorkoutsProvider);
    final profile = ref.watch(userProfileStreamProvider).value;
    final stepGoal = profile?.dailyStepEstimate ?? 8000;

    // Auto-save steps to Isar whenever they update
    ref.listen<AsyncValue<int>>(liveStepsProvider, (_, next) {
      next.whenData((steps) {
        if (steps > 0) {
          ref.read(activityNotifierProvider.notifier).saveStepCount(steps);
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Activity')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Steps Section ─────────────────────────────────────────────
            stepsAsync.when(
              data: (steps) =>
                  _StepsSection(steps: steps, goal: stepGoal, ref: ref)
                      .animate()
                      .fadeIn(duration: 400.ms),
              loading: () => const SizedBox(height: 100),
              error: (_, __) =>
                  _StepsSection(steps: 0, goal: stepGoal, ref: ref),
            ),

            const SizedBox(height: 28),

            // ── Log Workout ───────────────────────────────────────────────
            _SectionHeader(title: 'Log Workout', icon: '🏋️'),
            const SizedBox(height: 12),
            _WorkoutForm(
              nameCtrl: _workoutNameCtrl,
              setsCtrl: _setsCtrl,
              repsCtrl: _repsCtrl,
              durationCtrl: _durationCtrl,
              onLog: _logWorkout,
            ),

            const SizedBox(height: 28),

            // ── Today's Workouts ──────────────────────────────────────────
            _SectionHeader(title: "Today's Workouts", icon: '📋'),
            const SizedBox(height: 12),
            workoutsAsync.when(
              data: (workouts) {
                if (workouts.isEmpty) {
                  return _EmptyState(
                    emoji: '🏃',
                    message: 'No workouts logged today',
                  );
                }
                return Column(
                  children: workouts
                      .map((w) => _WorkoutTile(workout: w, ref: ref))
                      .toList(),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logWorkout() async {
    final name = _workoutNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter workout name'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final profile = ref.read(userProfileStreamProvider).value;
    final bodyWeight = profile?.weight ?? 70.0;
    final duration = int.tryParse(_durationCtrl.text) ?? 30;

    final estimatedBurn = WorkoutCalorieCalculator.calculateBurn(name, duration, bodyWeight);

    await ref.read(activityNotifierProvider.notifier).logWorkout(
          name: name,
          sets: int.tryParse(_setsCtrl.text) ?? 3,
          reps: int.tryParse(_repsCtrl.text) ?? 12,
          durationMinutes: duration,
          estimatedBurn: estimatedBurn,
        );

    _workoutNameCtrl.clear();
    ref.invalidate(todayWorkoutsProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✓ Workout logged (~$estimatedBurn kcal estimated)',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}

class _StepsSection extends StatelessWidget {
  final int steps;
  final int goal;
  final WidgetRef ref;

  const _StepsSection({
    required this.steps,
    required this.goal,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final pct = goal > 0 ? (steps / goal).clamp(0.0, 1.0) : 0.0;
    final remaining = (goal - steps).clamp(0, goal);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withOpacity(0.2),
            AppColors.cardBg,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps.toString(),
                    style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary),
                  ),
                  Text('/ $goal steps',
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 16)),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.directions_walk_rounded,
                    color: AppColors.accent, size: 40),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppColors.surfaceLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pct >= 1.0 ? '🎉 Goal Complete!' : '$remaining more steps',
                style: TextStyle(
                    color: pct >= 1.0 ? AppColors.success : AppColors.textSecondary,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${(pct * 100).round()}%',
                style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkoutForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController setsCtrl;
  final TextEditingController repsCtrl;
  final TextEditingController durationCtrl;
  final VoidCallback onLog;

  const _WorkoutForm({
    required this.nameCtrl,
    required this.setsCtrl,
    required this.repsCtrl,
    required this.durationCtrl,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Exercise Name',
              hintText: 'e.g. Push-ups, Running, Cycling',
              prefixIcon: Icon(Icons.fitness_center_rounded),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: setsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Sets'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: repsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Reps'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: durationCtrl,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Duration (min)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onLog,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Log Workout'),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutTile extends StatelessWidget {
  final dynamic workout;
  final WidgetRef ref;

  const _WorkoutTile({required this.workout, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.fitness_center_rounded,
                color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(workout.workoutName ?? 'Workout',
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                Text(
                    '${workout.sets} sets × ${workout.reps} reps • ${workout.durationMinutes} min',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${workout.estimatedCaloriesBurned} kcal',
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              const Text('burned',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: AppColors.textMuted, size: 18),
            onPressed: () async {
              await ref
                  .read(activityNotifierProvider.notifier)
                  .deleteActivity(workout.id);
              ref.invalidate(todayWorkoutsProvider);
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
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

class _EmptyState extends StatelessWidget {
  final String emoji;
  final String message;

  const _EmptyState({required this.emoji, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(message,
                style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
