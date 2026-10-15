import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_profile.dart';
import '../data/repositories/user_repository.dart';
import '../core/utils/bmr_calculator.dart';
import 'auth_provider.dart';
import '../core/services/analytics_service.dart';
import '../core/services/sync_service.dart';
import '../data/models/weight_log.dart';
import '../data/repositories/weight_activity_repository.dart';

// ── Current user profile ─────────────────────────────────────────────────
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(userRepositoryProvider);
  return repo.getProfile(uid);
});

// ── Watch profile for realtime ────────────────────────────────────────────
final userProfileStreamProvider = StreamProvider<UserProfile?>((ref) {
  final uid = ref.watch(currentUidProvider);
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchProfile(uid);
});

// ── Onboarding completed? ─────────────────────────────────────────────────
final onboardingCompleteProvider = Provider<bool>((ref) {
  final profile = ref.watch(userProfileStreamProvider).value;
  return profile?.onboardingComplete ?? false;
});

// ── Onboarding state machine ───────────────────────────────────────────────
class OnboardingState {
  final int step;
  final int age;
  final Gender gender;
  final double weight;
  final double height;
  final double? goalWeight;
  final UserGoal goal;
  final ActivityLevel activityLevel;
  final DietPreference dietPreference;
  final int sleepHours;
  final int dailyStepEstimate;
  final String name;

  const OnboardingState({
    this.step = 0,
    this.age = 25,
    this.gender = Gender.male,
    this.weight = 70.0,
    this.height = 170.0,
    this.goalWeight,
    this.goal = UserGoal.lose,
    this.activityLevel = ActivityLevel.moderate,
    this.dietPreference = DietPreference.normal,
    this.sleepHours = 7,
    this.dailyStepEstimate = 5000,
    this.name = '',
  });

  OnboardingState copyWith({
    int? step,
    int? age,
    Gender? gender,
    double? weight,
    double? height,
    double? goalWeight,
    UserGoal? goal,
    ActivityLevel? activityLevel,
    DietPreference? dietPreference,
    int? sleepHours,
    int? dailyStepEstimate,
    String? name,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goalWeight: goalWeight ?? this.goalWeight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      dietPreference: dietPreference ?? this.dietPreference,
      sleepHours: sleepHours ?? this.sleepHours,
      dailyStepEstimate: dailyStepEstimate ?? this.dailyStepEstimate,
      name: name ?? this.name,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref _ref;
  OnboardingNotifier(this._ref) : super(const OnboardingState());

  void nextStep() => state = state.copyWith(step: state.step + 1);
  void prevStep() {
    if (state.step > 0) state = state.copyWith(step: state.step - 1);
  }

  void setAge(int v) => state = state.copyWith(age: v);
  void setGender(Gender v) => state = state.copyWith(gender: v);
  void setWeight(double v) => state = state.copyWith(weight: v);
  void setHeight(double v) => state = state.copyWith(height: v);
  void setGoalWeight(double v) => state = state.copyWith(goalWeight: v);
  void setGoal(UserGoal v) => state = state.copyWith(goal: v);
  void setActivityLevel(ActivityLevel v) =>
      state = state.copyWith(activityLevel: v);
  void setDietPreference(DietPreference v) =>
      state = state.copyWith(dietPreference: v);
  void setSleepHours(int v) => state = state.copyWith(sleepHours: v);
  void setStepEstimate(int v) => state = state.copyWith(dailyStepEstimate: v);
  void setName(String v) => state = state.copyWith(name: v);

  Future<void> completeOnboarding() async {
    final uid = _ref.read(currentUidProvider);
    final repo = _ref.read(userRepositoryProvider);
    final s = state;

    final bmr = BmrCalculator.calculateBMR(
      weight: s.weight,
      height: s.height,
      age: s.age,
      gender: s.gender == Gender.male ? 'male' : 'female',
    );

    final actStr = _activityStr(s.activityLevel);
    final tdee = BmrCalculator.calculateTDEE(bmr: bmr, activityLevel: actStr);
    final goalStr = _goalStr(s.goal);
    final calorieTarget =
        BmrCalculator.calculateCalorieTarget(tdee: tdee, goal: goalStr);
    final proteinTarget =
        BmrCalculator.calculateProteinTarget(weight: s.weight, goal: goalStr, activityLevel: actStr);
    final dietStr = _dietStr(s.dietPreference);
    final fatTarget =
        BmrCalculator.calculateFatTarget(calorieTarget: calorieTarget, dietPreference: dietStr);
    final carbsTarget = BmrCalculator.calculateCarbsTarget(
      calorieTarget: calorieTarget,
      proteinGrams: proteinTarget,
      fatGrams: fatTarget,
      dietPreference: dietStr,
    );

    final firebaseUser = _ref.read(authStateProvider).value;
    final email = firebaseUser?.email ?? '';
    final name = s.name.isNotEmpty 
        ? s.name 
        : (firebaseUser?.displayName ?? (firebaseUser?.email?.split('@').first ?? ''));

    final existing = await repo.getProfile(uid);
    final profile = existing ?? UserProfile();
    profile
      ..uid = uid
      ..name = name.isNotEmpty ? name : (profile.name.isNotEmpty ? profile.name : 'User')
      ..email = email.isNotEmpty ? email : (profile.email.isNotEmpty ? profile.email : '')
      ..isGuest = false
      ..age = s.age
      ..gender = s.gender
      ..weight = s.weight
      ..height = s.height
      ..goalWeight = s.goalWeight
      ..goal = s.goal
      ..activityLevel = s.activityLevel
      ..dietPreference = s.dietPreference
      ..sleepHours = s.sleepHours
      ..dailyStepEstimate = s.dailyStepEstimate
      ..bmr = bmr
      ..tdee = tdee
      ..dailyCalorieTarget = calorieTarget
      ..dailyProteinTarget = proteinTarget
      ..dailyCarbsTarget = carbsTarget
      ..dailyFatTarget = fatTarget
      // Measurements stay null until user logs them (no fabricated defaults).
      ..onboardingComplete = true
      ..updatedAt = DateTime.now();

    await repo.saveProfile(profile);

    // Push to Firestore immediately so reinstall can restore this profile.
    try {
      await _ref.read(syncServiceProvider).pushUserProfileNow(uid);
    } catch (_) {}

    // ALSO save the initial weight and measurements log!
    try {
      final weightRepo = _ref.read(weightRepositoryProvider);
      final weightLog = WeightLog()
        ..uid = uid
        ..weight = s.weight
        ..notes = 'Initial weight from onboarding'
        ..loggedAt = DateTime.now()
        ..date = DateTime.now()
        ..waistCm = profile.waistCm
        ..neckCm = profile.neckCm
        ..hipCm = profile.hipCm;
      await weightRepo.logWeight(weightLog);
    } catch (e) {
      // ignore
    }
    
    // Log Onboarding Completion to Firebase Analytics
    try {
      await _ref.read(analyticsServiceProvider).logOnboardingComplete();
    } catch (_) {}
  }

  String _activityStr(ActivityLevel l) {
    switch (l) {
      case ActivityLevel.sedentary: return 'sedentary';
      case ActivityLevel.light: return 'light';
      case ActivityLevel.moderate: return 'moderate';
      case ActivityLevel.active: return 'active';
    }
  }

  String _goalStr(UserGoal g) {
    switch (g) {
      case UserGoal.lose: return 'lose';
      case UserGoal.maintain: return 'maintain';
      case UserGoal.gain: return 'gain';
    }
  }

  String _dietStr(DietPreference d) {
    switch (d) {
      case DietPreference.keto: return 'keto';
      case DietPreference.lowCarb: return 'low_carb';
      case DietPreference.highProtein: return 'high_protein';
      default: return 'normal';
    }
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});
