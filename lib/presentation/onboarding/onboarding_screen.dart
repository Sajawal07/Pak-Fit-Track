import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/bmr_calculator.dart';
import '../../core/utils/weight_units.dart';
import '../../data/models/user_profile.dart';
import '../../providers/user_provider.dart';
import '../../providers/weight_unit_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    const totalSteps = 6;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (state.step > 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: AppColors.textPrimary),
                          onPressed: () =>
                              ref.read(onboardingProvider.notifier).prevStep(),
                        )
                      else
                        const SizedBox(width: 40),
                      const Spacer(),
                      Text(
                        'Step ${state.step + 1} of $totalSteps',
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (state.step + 1) / totalSteps,
                      backgroundColor: AppColors.surfaceLight,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            ),

            // Step content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildStep(context, ref, state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, WidgetRef ref, OnboardingState state) {
    switch (state.step) {
      case 0:
        return const _BasicInfoStep(key: ValueKey(0));
      case 1:
        return const _GoalStep(key: ValueKey(1));
      case 2:
        return const _ActivityStep(key: ValueKey(2));
      case 3:
        return const _DietStep(key: ValueKey(3));
      case 4:
        return const _LifestyleStep(key: ValueKey(4));
      case 5:
        return const _SummaryStep(key: ValueKey(5));
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Step 1: Basic Info ───────────────────────────────────────────────────────
class _BasicInfoStep extends ConsumerStatefulWidget {
  const _BasicInfoStep({super.key});

  @override
  ConsumerState<_BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends ConsumerState<_BasicInfoStep> {
  late TextEditingController _nameCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _heightCtrl;

  @override
  void initState() {
    super.initState();
    final s = ref.read(onboardingProvider);
    final unit = ref.read(weightUnitProvider);
    _nameCtrl = TextEditingController(text: s.name);
    _ageCtrl = TextEditingController(text: s.age.toString());
    _weightCtrl = TextEditingController(
        text: WeightUnits.toDisplay(s.weight, unit).toStringAsFixed(1));
    _heightCtrl = TextEditingController(text: s.height.toString());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    final unit = ref.watch(weightUnitProvider);
    final unitLabel = WeightUnits.label(unit);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('Tell us about yourself', '👤'),
          const SizedBox(height: 32),

          // Name
          _field('Your Name', _nameCtrl, Icons.person_outline,
              onChanged: notifier.setName),
          const SizedBox(height: 16),

          // Gender
          Row(
            children: [
              Expanded(
                child: _genderCard(
                  label: 'Male',
                  icon: '👨',
                  selected: state.gender == Gender.male,
                  onTap: () => notifier.setGender(Gender.male),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _genderCard(
                  label: 'Female',
                  icon: '👩',
                  selected: state.gender == Gender.female,
                  onTap: () => notifier.setGender(Gender.female),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Age
          _field('Age (years)', _ageCtrl, Icons.cake_outlined,
              keyboardType: TextInputType.number,
              onChanged: (v) {
                final n = int.tryParse(v);
                if (n != null) notifier.setAge(n);
              }),
          const SizedBox(height: 16),

          Row(
            children: [
              const Text('Weight unit',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
              const Spacer(),
              SegmentedButton<WeightUnit>(
                segments: const [
                  ButtonSegment(value: WeightUnit.kg, label: Text('kg')),
                  ButtonSegment(value: WeightUnit.lbs, label: Text('lbs')),
                ],
                selected: {unit},
                onSelectionChanged: (s) async {
                  final next = s.first;
                  final currentKg = state.weight;
                  await ref.read(weightUnitProvider.notifier).setUnit(next);
                  _weightCtrl.text =
                      WeightUnits.toDisplay(currentKg, next).toStringAsFixed(1);
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.textOnPrimary;
                    }
                    return AppColors.textSecondary;
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(children: [
            Expanded(
              child: _field('Weight ($unitLabel)', _weightCtrl,
                  Icons.monitor_weight_outlined,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) {
                    final n = double.tryParse(v);
                    if (n != null) {
                      notifier.setWeight(WeightUnits.toKg(n, unit));
                    }
                  }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _field('Height (cm)', _heightCtrl, Icons.height_rounded,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (v) {
                    final n = double.tryParse(v);
                    if (n != null) notifier.setHeight(n);
                  }),
            ),
          ]),

          const SizedBox(height: 40),
          _nextButton(context, ref),
        ],
      ),
    );
  }

  Widget _genderCard({
    required String label,
    required String icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.15)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }
}

// ─── Step 2: Goal ─────────────────────────────────────────────────────────────
class _GoalStep extends ConsumerStatefulWidget {
  const _GoalStep({super.key});

  @override
  ConsumerState<_GoalStep> createState() => _GoalStepState();
}

class _GoalStepState extends ConsumerState<_GoalStep> {
  late TextEditingController _goalWeightCtrl;

  @override
  void initState() {
    super.initState();
    final s = ref.read(onboardingProvider);
    final unit = ref.read(weightUnitProvider);
    _goalWeightCtrl = TextEditingController(
      text: s.goalWeight != null
          ? WeightUnits.toDisplay(s.goalWeight!, unit).toStringAsFixed(1)
          : '',
    );
  }

  @override
  void dispose() {
    _goalWeightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    final unit = ref.watch(weightUnitProvider);
    final unitLabel = WeightUnits.label(unit);

    final goals = [
      (goal: UserGoal.lose, icon: '🔥', title: 'Lose Weight', subtitle: 'Burn fat & get lean'),
      (goal: UserGoal.maintain, icon: '⚖️', title: 'Maintain Weight', subtitle: 'Stay at current weight'),
      (goal: UserGoal.gain, icon: '💪', title: 'Gain Muscle', subtitle: 'Build strength & muscle'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('What\'s your goal?', '🎯'),
          const SizedBox(height: 32),
          ...goals.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _selectionCard(
                  icon: g.icon,
                  title: g.title,
                  subtitle: g.subtitle,
                  selected: state.goal == g.goal,
                  onTap: () {
                    notifier.setGoal(g.goal);
                    if (g.goal == UserGoal.maintain) {
                      notifier.setGoalWeight(state.weight);
                      _goalWeightCtrl.text =
                          WeightUnits.toDisplay(state.weight, unit)
                              .toStringAsFixed(1);
                    }
                  },
                ),
              )),
          if (state.goal != UserGoal.maintain) ...[
            const SizedBox(height: 24),
            Text('Target Weight ($unitLabel)',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _field('', _goalWeightCtrl, Icons.flag_circle_outlined,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) {
                  final n = double.tryParse(v);
                  if (n != null) {
                    notifier.setGoalWeight(WeightUnits.toKg(n, unit));
                  }
                }),
          ],
          const SizedBox(height: 24),
          _nextButton(context, ref),
        ],
      ),
    );
  }
}

// ─── Step 3: Activity ─────────────────────────────────────────────────────────
class _ActivityStep extends ConsumerWidget {
  const _ActivityStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    final levels = [
      (level: ActivityLevel.sedentary, icon: '🪑', title: 'Sedentary', subtitle: 'Little to no exercise'),
      (level: ActivityLevel.light, icon: '🚶', title: 'Light Activity', subtitle: '1–3 days/week'),
      (level: ActivityLevel.moderate, icon: '🏃', title: 'Moderate', subtitle: '3–5 days/week'),
      (level: ActivityLevel.active, icon: '⚡', title: 'Very Active', subtitle: 'Daily intense exercise'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('Activity level?', '🏋️'),
          const SizedBox(height: 32),
          ...levels.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _selectionCard(
                  icon: l.icon,
                  title: l.title,
                  subtitle: l.subtitle,
                  selected: state.activityLevel == l.level,
                  onTap: () => notifier.setActivityLevel(l.level),
                ),
              )),
          const SizedBox(height: 24),
          _nextButton(context, ref),
        ],
      ),
    );
  }
}

// ─── Step 4: Diet ─────────────────────────────────────────────────────────────
class _DietStep extends ConsumerWidget {
  const _DietStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    final diets = [
      (pref: DietPreference.normal, icon: '🍽️', title: 'Balanced Diet', subtitle: 'No restrictions'),
      (pref: DietPreference.highProtein, icon: '🥩', title: 'High Protein', subtitle: 'More protein, less carbs'),
      (pref: DietPreference.lowCarb, icon: '🥦', title: 'Low Carb', subtitle: 'Reduced carbohydrates'),
      (pref: DietPreference.keto, icon: '🥑', title: 'Keto', subtitle: 'Very low carb, high fat'),
      (pref: DietPreference.pakistaniTraditional, icon: '🫓', title: 'Pakistani Traditional', subtitle: 'Roti, daal, sabzi'),
      (pref: DietPreference.vegetarian, icon: '🌱', title: 'Vegetarian', subtitle: 'No meat'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('Diet preference?', '🥗'),
          const SizedBox(height: 32),
          ...diets.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _selectionCard(
                  icon: d.icon,
                  title: d.title,
                  subtitle: d.subtitle,
                  selected: state.dietPreference == d.pref,
                  onTap: () => notifier.setDietPreference(d.pref),
                ),
              )),
          const SizedBox(height: 24),
          _nextButton(context, ref),
        ],
      ),
    );
  }
}

// ─── Step 5: Lifestyle ────────────────────────────────────────────────────────
class _LifestyleStep extends ConsumerStatefulWidget {
  const _LifestyleStep({super.key});

  @override
  ConsumerState<_LifestyleStep> createState() => _LifestyleStepState();
}

class _LifestyleStepState extends ConsumerState<_LifestyleStep> {
  late int _sleep;
  late int _steps;

  @override
  void initState() {
    super.initState();
    final s = ref.read(onboardingProvider);
    _sleep = s.sleepHours;
    _steps = s.dailyStepEstimate;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(onboardingProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('Lifestyle inputs', '😴'),
          const SizedBox(height: 32),

          _sliderCard(
            icon: '😴',
            title: 'Sleep hours',
            value: _sleep.toDouble(),
            min: 4,
            max: 12,
            divisions: 8,
            label: '$_sleep hrs',
            onChanged: (v) {
              setState(() => _sleep = v.round());
              notifier.setSleepHours(v.round());
            },
          ),
          const SizedBox(height: 20),
          _sliderCard(
            icon: '👣',
            title: 'Daily steps (estimate)',
            value: _steps.toDouble(),
            min: 1000,
            max: 20000,
            divisions: 19,
            label: '${(_steps / 1000).toStringAsFixed(1)}k',
            onChanged: (v) {
              setState(() => _steps = v.round());
              notifier.setStepEstimate(v.round());
            },
          ),

          const SizedBox(height: 40),
          _nextButton(context, ref),
        ],
      ),
    );
  }

  Widget _sliderCard({
    required String icon,
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String label,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(label,
                    style: const TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.surfaceLight,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ─── Step 6: Summary ─────────────────────────────────────────────────────────
class _SummaryStep extends ConsumerStatefulWidget {
  const _SummaryStep({super.key});

  @override
  ConsumerState<_SummaryStep> createState() => _SummaryStepState();
}

class _SummaryStepState extends ConsumerState<_SummaryStep> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    final bmr = BmrCalculator.calculateBMR(
      weight: state.weight,
      height: state.height,
      age: state.age,
      gender: state.gender == Gender.male ? 'male' : 'female',
    );
    final actStr = state.activityLevel.name == 'sedentary'
        ? 'sedentary'
        : state.activityLevel.name == 'light'
            ? 'light'
            : state.activityLevel.name == 'active'
                ? 'active'
                : 'moderate';
    final tdee = BmrCalculator.calculateTDEE(bmr: bmr, activityLevel: actStr);
    final goalStr = state.goal == UserGoal.lose
        ? 'lose'
        : state.goal == UserGoal.gain
            ? 'gain'
            : 'maintain';
    final calorieTarget =
        BmrCalculator.calculateCalorieTarget(tdee: tdee, goal: goalStr);
    final proteinTarget = BmrCalculator.calculateProteinTarget(
        weight: state.weight, goal: goalStr, activityLevel: actStr);
    final bmi = BmrCalculator.calculateBMI(
        weight: state.weight, height: state.height);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _stepTitle('Your Plan', '📋'),
          const SizedBox(height: 24),

          // Summary cards
          _summaryGrid([
            _SummaryItem('BMR', '${bmr.round()} kcal', '🔥'),
            _SummaryItem('TDEE', '${tdee.round()} kcal', '⚡'),
            _SummaryItem('Daily Target', '$calorieTarget kcal', '🎯'),
            _SummaryItem('Protein Goal', '${proteinTarget}g/day', '💪'),
            _SummaryItem('BMI', bmi.toStringAsFixed(1), '📊'),
            _SummaryItem(
                'Category', BmrCalculator.bmiCategory(bmi), '🏷️'),
          ]),

          if (BmrCalculator.bmiCategory(bmi) == 'Obese' ||
              BmrCalculator.bmiCategory(bmi) == 'Overweight') ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.warning.withOpacity(0.35)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.medical_services_outlined,
                      color: AppColors.warning, size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'BMI sirf ek estimate hai. Weight loss plan start karne se pehle doctor se mashwara lein — especially agar koi medical condition ho.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These targets will be used to personalize your daily nutrition tracking.',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : () => _confirm(context, ref),
              child: _loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: Colors.white))
                  : const Text('Let\'s Start! 🚀'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    setState(() => _loading = true);
    try {
      await ref.read(onboardingProvider.notifier).completeOnboarding();
      if (context.mounted) context.go('/dashboard');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _summaryGrid(List<_SummaryItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 6),
              Text(item.value,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Text(item.label,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryItem {
  final String label;
  final String value;
  final String emoji;
  const _SummaryItem(this.label, this.value, this.emoji);
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

Widget _stepTitle(String title, String emoji) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(emoji, style: const TextStyle(fontSize: 40)),
      const SizedBox(height: 12),
      Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    ],
  );
}

Widget _field(
  String label,
  TextEditingController ctrl,
  IconData icon, {
  TextInputType keyboardType = TextInputType.text,
  required ValueChanged<String> onChanged,
}) {
  return TextFormField(
    controller: ctrl,
    keyboardType: keyboardType,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
    ),
  );
}

Widget _selectionCard({
  required String icon,
  required String title,
  required String subtitle,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            selected ? AppColors.primary.withOpacity(0.12) : AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle_rounded,
                color: AppColors.primary, size: 22),
        ],
      ),
    ),
  );
}

Widget _nextButton(BuildContext context, WidgetRef ref) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: () => ref.read(onboardingProvider.notifier).nextStep(),
      child: const Text('Continue'),
    ),
  );
}
