import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/bmr_calculator.dart';
import '../../core/utils/weight_units.dart';
import '../../data/models/user_profile.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/weight_unit_provider.dart';
import '../../data/repositories/user_repository.dart';
import '../../core/services/account_deletion_service.dart';
import '../../core/services/account_local_cleanup_service.dart';
import '../../core/services/privacy_preferences_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/constants/prefs_keys.dart';
import '../../core/services/step_tracker_service.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import 'educational_info_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _editMode = false;
  bool _profileSynced = false;
  late TextEditingController _nameCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _goalWeightCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _waistCtrl;
  late TextEditingController _neckCtrl;
  late TextEditingController _hipCtrl;
  late TextEditingController _passwordCtrl;
  Gender _editGender = Gender.male;
  ActivityLevel _editActivity = ActivityLevel.moderate;
  UserGoal _editGoal = UserGoal.lose;
  DietPreference _editDiet = DietPreference.normal;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _weightCtrl = TextEditingController();
    _goalWeightCtrl = TextEditingController();
    _ageCtrl = TextEditingController();
    _heightCtrl = TextEditingController();
    _waistCtrl = TextEditingController();
    _neckCtrl = TextEditingController();
    _hipCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  Future<void> _syncProfileFromFirebase(
      UserProfile profile, User firebaseUser) async {
    _profileSynced = true;
    profile.email = firebaseUser.email ?? profile.email;
    if (profile.name.isEmpty ||
        profile.name == 'Guest User' ||
        profile.name == 'User') {
      profile.name = firebaseUser.displayName ??
          firebaseUser.email?.split('@').first ??
          'User';
    }
    profile.isGuest = false;
    await ref.read(userRepositoryProvider).saveProfile(profile);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _weightCtrl.dispose();
    _goalWeightCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _waistCtrl.dispose();
    _neckCtrl.dispose();
    _hipCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _enterEditMode(UserProfile profile, WeightUnit unit) {
    _nameCtrl.text = profile.name;
    _weightCtrl.text =
        WeightUnits.toDisplay(profile.weight, unit).toStringAsFixed(1);
    if (profile.goalWeight != null) {
      _goalWeightCtrl.text =
          WeightUnits.toDisplay(profile.goalWeight!, unit).toStringAsFixed(1);
    } else {
      _goalWeightCtrl.clear();
    }
    _ageCtrl.text = profile.age.toString();
    _heightCtrl.text = profile.height.round().toString();
    _waistCtrl.text = profile.waistCm?.toString() ?? '';
    _neckCtrl.text = profile.neckCm?.toString() ?? '';
    _hipCtrl.text = profile.hipCm?.toString() ?? '';
    _editGender = profile.gender;
    _editActivity = profile.activityLevel;
    _editGoal = profile.goal;
    _editDiet = profile.dietPreference;
    setState(() => _editMode = true);
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileStreamProvider);

    // Riverpod rule: ref.listen must be called during build for ConsumerState.
    // Keep it idempotent with `_profileSynced` so it doesn't resync repeatedly.
    ref.listen<AsyncValue<UserProfile?>>(userProfileStreamProvider, (_, next) {
      final profile = next.value;
      final firebaseUser = ref.read(authStateProvider).value;
      if (profile == null ||
          firebaseUser == null ||
          _profileSynced ||
          (!profile.isGuest &&
              profile.email.isNotEmpty &&
              profile.name.isNotEmpty &&
              profile.name != 'Guest User' &&
              profile.name != 'User')) {
        return;
      }
      if (profile.isGuest ||
          profile.email.isEmpty ||
          profile.name.isEmpty ||
          profile.name == 'Guest User' ||
          profile.name == 'User') {
        _syncProfileFromFirebase(profile, firebaseUser);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.textSecondary),
            onPressed: () => EducationalInfoSheet.show(context),
            tooltip: 'Health Metrics Guide',
          ),
          TextButton(
            onPressed: () {
              if (_editMode) {
                setState(() => _editMode = false);
              } else {
                final p = ref.read(userProfileStreamProvider).valueOrNull;
                if (p != null) {
                  _enterEditMode(p, ref.read(weightUnitProvider));
                }
              }
            },
            child: Text(_editMode ? 'Cancel' : 'Edit',
                style: const TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) return _noProfile(context);

          final firebaseUser = ref.watch(authStateProvider).value;

          final displayName = profile.name.isNotEmpty && profile.name != 'Guest User'
              ? profile.name
              : (firebaseUser?.displayName ?? (firebaseUser?.email?.split('@').first ?? 'User'));
          final displayEmail = profile.email.isNotEmpty
              ? profile.email
              : (firebaseUser?.email ?? 'Signed in');

          // Populate controllers on load
          final unit = ref.watch(weightUnitProvider);
          if (_nameCtrl.text.isEmpty) { _nameCtrl.text = displayName; }
          if (_weightCtrl.text.isEmpty) {
            _weightCtrl.text =
                WeightUnits.toDisplay(profile.weight, unit).toStringAsFixed(1);
          }
          if (_goalWeightCtrl.text.isEmpty && profile.goalWeight != null) {
            _goalWeightCtrl.text =
                WeightUnits.toDisplay(profile.goalWeight!, unit)
                    .toStringAsFixed(1);
          }
          if (_waistCtrl.text.isEmpty && profile.waistCm != null) {
            _waistCtrl.text = profile.waistCm.toString();
          }
          if (_neckCtrl.text.isEmpty && profile.neckCm != null) {
            _neckCtrl.text = profile.neckCm.toString();
          }
          if (_hipCtrl.text.isEmpty && profile.hipCm != null) {
            _hipCtrl.text = profile.hipCm.toString();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Profile Header ──────────────────────────────────────
                _ProfileHeader(
                  profile: profile,
                  displayName: displayName,
                  displayEmail: displayEmail,
                )
                    .animate()
                    .fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // ── Edit fields ──────────────────────────────────────────
                if (_editMode) ...[
                  _EditSection(
                    profile: profile,
                    nameCtrl: _nameCtrl,
                    weightCtrl: _weightCtrl,
                    goalWeightCtrl: _goalWeightCtrl,
                    ageCtrl: _ageCtrl,
                    heightCtrl: _heightCtrl,
                    waistCtrl: _waistCtrl,
                    neckCtrl: _neckCtrl,
                    hipCtrl: _hipCtrl,
                    gender: _editGender,
                    activity: _editActivity,
                    goal: _editGoal,
                    diet: _editDiet,
                    onGenderChanged: (v) => setState(() => _editGender = v),
                    onActivityChanged: (v) => setState(() => _editActivity = v),
                    onGoalChanged: (v) => setState(() => _editGoal = v),
                    onDietChanged: (v) => setState(() => _editDiet = v),
                    weightUnit: unit,
                    onUnitChanged: (next) async {
                      final currentKg = double.tryParse(_weightCtrl.text);
                      final goalVal = double.tryParse(_goalWeightCtrl.text);
                      // Controllers hold display units — convert via current unit first
                      final kg = currentKg != null
                          ? WeightUnits.toKg(currentKg, unit)
                          : profile.weight;
                      final goalKg = goalVal != null
                          ? WeightUnits.toKg(goalVal, unit)
                          : profile.goalWeight;
                      await ref
                          .read(weightUnitProvider.notifier)
                          .setUnit(next);
                      _weightCtrl.text =
                          WeightUnits.toDisplay(kg, next).toStringAsFixed(1);
                      if (goalKg != null) {
                        _goalWeightCtrl.text =
                            WeightUnits.toDisplay(goalKg, next)
                                .toStringAsFixed(1);
                      }
                      setState(() {});
                    },
                    onSave: () => _saveProfile(profile),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 24),
                ],

                // ── Stats cards ──────────────────────────────────────────
                _StatsGrid(profile: profile)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms),

                const SizedBox(height: 24),

                // ── Body Measurements ────────────────────────────────────
                _MeasurementsCard(profile: profile)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 120.ms),

                const SizedBox(height: 24),

                // ── Targets ──────────────────────────────────────────────
                _TargetsCard(profile: profile)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 150.ms),

                const SizedBox(height: 24),

                // ── Settings ─────────────────────────────────────────────
                _PrivacyDataSection()
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 180.ms),
                const SizedBox(height: 16),
                _SettingsSection(
                  onRedo: () => context.go('/onboarding'),
                  onSignOut: () => _signOut(context),
                  onDeleteAccount: () => _deleteAccount(context),
                ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
              ],
            ),
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (_, __) => const Center(child: Text('Error loading profile')),
      ),
    );
  }

  Future<void> _saveProfile(UserProfile profile) async {
    final unit = ref.read(weightUnitProvider);
    final n = double.tryParse(_weightCtrl.text);
    final g = double.tryParse(_goalWeightCtrl.text);
    final age = int.tryParse(_ageCtrl.text.trim());
    final height = double.tryParse(_heightCtrl.text.trim());
    final w = double.tryParse(_waistCtrl.text);
    final nk = double.tryParse(_neckCtrl.text);
    final h = double.tryParse(_hipCtrl.text);

    profile
      ..name = _nameCtrl.text.trim()
      ..age = age ?? profile.age
      ..height = height ?? profile.height
      ..gender = _editGender
      ..activityLevel = _editActivity
      ..goal = _editGoal
      ..dietPreference = _editDiet
      ..weight = n != null ? WeightUnits.toKg(n, unit) : profile.weight
      ..goalWeight = g != null ? WeightUnits.toKg(g, unit) : null
      ..waistCm = w
      ..neckCm = nk
      ..hipCm = h
      ..updatedAt = DateTime.now();

    // Recalculate targets (same logic as onboarding)
    final actStr = profile.activityLevel.name;
    final goalStr = profile.goal.name;
    final dietStr = switch (profile.dietPreference) {
      DietPreference.keto => 'keto',
      DietPreference.lowCarb => 'low_carb',
      DietPreference.highProtein => 'high_protein',
      _ => 'normal',
    };
    final bmr = BmrCalculator.calculateBMR(
      weight: profile.weight,
      height: profile.height,
      age: profile.age,
      gender: profile.gender == Gender.male ? 'male' : 'female',
    );
    final tdee = BmrCalculator.calculateTDEE(bmr: bmr, activityLevel: actStr);
    final calorieTarget =
        BmrCalculator.calculateCalorieTarget(tdee: tdee, goal: goalStr);
    final proteinTarget = BmrCalculator.calculateProteinTarget(
      weight: profile.weight,
      goal: goalStr,
      activityLevel: actStr,
    );
    final fatTarget = BmrCalculator.calculateFatTarget(
      calorieTarget: calorieTarget,
      dietPreference: dietStr,
    );
    final carbsTarget = BmrCalculator.calculateCarbsTarget(
      calorieTarget: calorieTarget,
      proteinGrams: proteinTarget,
      fatGrams: fatTarget,
      dietPreference: dietStr,
    );
    profile
      ..bmr = bmr
      ..tdee = tdee
      ..dailyCalorieTarget = calorieTarget
      ..dailyProteinTarget = proteinTarget
      ..dailyFatTarget = fatTarget
      ..dailyCarbsTarget = carbsTarget;

    await ref.read(userRepositoryProvider).saveProfile(profile);
    try {
      await ref.read(syncServiceProvider).pushUserProfileNow(profile.uid);
    } catch (_) {}

    setState(() => _editMode = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Profile updated'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Request account deletion',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This submits a deletion request — it does not delete your account immediately.\n\n'
          'An administrator will manually review and process your request. '
          'Until the request is processed, your account and cloud data remain stored.\n\n'
          'Once your request is recorded, the fitness data stored on this device will be cleared and you will be signed out.\n\n'
          'To follow up at any time, email Sajawal0005@gmail.com from your registered email address.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Submit Request'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    if (!context.mounted) return;
    final auth = ref.read(firebaseAuthProvider);
    final user = auth?.currentUser;
    if (user == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must be signed in to request deletion.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    try {
      final service = ref.read(accountDeletionServiceProvider);

      final hasPending = await service.hasPendingRequest();
      if (!context.mounted) return;
      if (hasPending) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Your account deletion request is already pending. '
                'To follow up, email Sajawal0005@gmail.com from your registered email address.'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }

      final reauthResult = await service.performReauthentication();
      if (!context.mounted) return;
      if (!reauthResult.success && reauthResult.requiresPassword) {
        final passwordResult = await _showPasswordDialog(context);
        if (!context.mounted || passwordResult == null) return;

        final reauth = await service.reauthenticateWithPassword(passwordResult);
        if (!context.mounted) return;
        if (!reauth.success) {
          _showErrorSnackBar(context, reauth.message);
          return;
        }
      } else if (!reauthResult.success) {
        if (!context.mounted) return;
        _showErrorSnackBar(context, reauthResult.message);
        return;
      }

      if (!context.mounted) return;
      final submitResult = await service.submitDeletionRequest();
      if (!context.mounted) return;
      if (!submitResult.success) {
        _showErrorSnackBar(context, submitResult.message);
        return;
      }

      // The request is now recorded in Firestore (status "pending").
      // 1) Stop cloud sync first so nothing can be pushed or re-pulled
      //    between cleanup and sign-out.
      // 2) Clear this user's LOCAL device data. Cloud records are deleted
      //    later, manually, by the administrator (docs/ACCOUNT_DELETION.md).
      // The pending request itself lives in Firestore and is unaffected.
      try {
        ref.read(syncServiceProvider).stopPeriodicSync();
      } catch (_) {}
      try {
        await ref
            .read(accountLocalCleanupServiceProvider)
            .clearLocalDataForDeletionRequest(user.uid);
      } catch (e) {
        // Cleanup is best-effort; the request itself already succeeded.
        debugPrint('[AccountDeletion] Local cleanup failed: $e');
      }

      if (context.mounted) _showSuccessAndSignOut(context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _getFriendlyErrorMessage(e),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<String?> _showPasswordDialog(BuildContext context) async {
    _passwordCtrl.clear();
    return await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Confirm identity',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'For security, please enter your current password to confirm account deletion.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, _passwordCtrl.text),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showSuccessAndSignOut(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Deletion request submitted',
          style: TextStyle(color: AppColors.success),
        ),
        content: const Text(
          'Your account deletion request has been recorded.\n\n'
          'Your account and cloud data have NOT been deleted yet — an administrator will now process your request manually.\n\n'
          'The fitness data stored on this device has been cleared. Tap OK to sign out.\n\n'
          'To follow up, email Sajawal0005@gmail.com from your registered email address.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) context.go('/auth');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  String _getFriendlyErrorMessage(dynamic error) {
    final raw = error.toString().toLowerCase();
    if (raw.contains('permission-denied') || raw.contains('permission_denied')) {
      return 'You do not have permission to submit a deletion request.';
    }
    if (raw.contains('network') || raw.contains('unavailable')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  Future<void> _signOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Sign Out',
            style: TextStyle(color: AppColors.textPrimary)),
        content: const Text('Are you sure?',
            style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(authNotifierProvider.notifier).signOut();
      if (context.mounted) context.go('/auth');
    }
  }

  Widget _noProfile(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No profile found'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/onboarding'),
            child: const Text('Complete Onboarding'),
          ),
        ],
      ),
    );
  }
}

// ── Profile Header ────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final String displayName;
  final String displayEmail;
  
  const _ProfileHeader({
    required this.profile,
    required this.displayName,
    required this.displayEmail,
  });

  @override
  Widget build(BuildContext context) {
    final bmi = BmrCalculator.calculateBMI(
        weight: profile.weight, height: profile.height);
    final category = BmrCalculator.bmiCategory(bmi);
    final showDoctorNudge =
        category == 'Obese' || category == 'Overweight';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary),
                    ),
                    Text(
                      displayEmail,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _badge('BMI ${bmi.toStringAsFixed(1)}'),
                        const SizedBox(width: 6),
                        _badge(category),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showDoctorNudge) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.medical_services_outlined,
                      color: AppColors.warning, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Consult a doctor before starting any weight-loss plan. BMI is an estimate only.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }
}

// ── Edit Section ──────────────────────────────────────────────────────────────
class _EditSection extends StatelessWidget {
  final UserProfile profile;
  final TextEditingController nameCtrl;
  final TextEditingController weightCtrl;
  final TextEditingController goalWeightCtrl;
  final TextEditingController ageCtrl;
  final TextEditingController heightCtrl;
  final TextEditingController waistCtrl;
  final TextEditingController neckCtrl;
  final TextEditingController hipCtrl;
  final Gender gender;
  final ActivityLevel activity;
  final UserGoal goal;
  final DietPreference diet;
  final ValueChanged<Gender> onGenderChanged;
  final ValueChanged<ActivityLevel> onActivityChanged;
  final ValueChanged<UserGoal> onGoalChanged;
  final ValueChanged<DietPreference> onDietChanged;
  final WeightUnit weightUnit;
  final ValueChanged<WeightUnit> onUnitChanged;
  final VoidCallback onSave;

  const _EditSection({
    required this.profile,
    required this.nameCtrl,
    required this.weightCtrl,
    required this.goalWeightCtrl,
    required this.ageCtrl,
    required this.heightCtrl,
    required this.waistCtrl,
    required this.neckCtrl,
    required this.hipCtrl,
    required this.gender,
    required this.activity,
    required this.goal,
    required this.diet,
    required this.onGenderChanged,
    required this.onActivityChanged,
    required this.onGoalChanged,
    required this.onDietChanged,
    required this.weightUnit,
    required this.onUnitChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final unitLabel = WeightUnits.label(weightUnit);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Edit Profile',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          const SizedBox(height: 16),
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age (years)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: heightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Gender',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 6),
          SegmentedButton<Gender>(
            segments: const [
              ButtonSegment(value: Gender.male, label: Text('Male')),
              ButtonSegment(value: Gender.female, label: Text('Female')),
            ],
            selected: {gender},
            onSelectionChanged: (s) => onGenderChanged(s.first),
          ),
          const SizedBox(height: 12),
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
                selected: {weightUnit},
                onSelectionChanged: (s) => onUnitChanged(s.first),
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: weightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Current Weight ($unitLabel)',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: goalWeightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Goal Weight ($unitLabel)',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Activity level',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<ActivityLevel>(
            value: activity,
            dropdownColor: AppColors.surface,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(
                  value: ActivityLevel.sedentary, child: Text('Sedentary')),
              DropdownMenuItem(
                  value: ActivityLevel.light, child: Text('Light')),
              DropdownMenuItem(
                  value: ActivityLevel.moderate, child: Text('Moderate')),
              DropdownMenuItem(
                  value: ActivityLevel.active, child: Text('Active')),
            ],
            onChanged: (v) {
              if (v != null) onActivityChanged(v);
            },
          ),
          const SizedBox(height: 12),
          const Text('Goal',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<UserGoal>(
            value: goal,
            dropdownColor: AppColors.surface,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: UserGoal.lose, child: Text('Lose Fat')),
              DropdownMenuItem(
                  value: UserGoal.maintain, child: Text('Maintain')),
              DropdownMenuItem(
                  value: UserGoal.gain, child: Text('Gain Muscle')),
            ],
            onChanged: (v) {
              if (v != null) onGoalChanged(v);
            },
          ),
          const SizedBox(height: 12),
          const Text('Diet preference',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<DietPreference>(
            value: diet,
            dropdownColor: AppColors.surface,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(
                  value: DietPreference.normal, child: Text('Balanced')),
              DropdownMenuItem(
                  value: DietPreference.highProtein,
                  child: Text('High Protein')),
              DropdownMenuItem(
                  value: DietPreference.lowCarb, child: Text('Low Carb')),
              DropdownMenuItem(
                  value: DietPreference.keto, child: Text('Keto')),
              DropdownMenuItem(
                  value: DietPreference.pakistaniTraditional,
                  child: Text('Pakistani')),
              DropdownMenuItem(
                  value: DietPreference.vegetarian,
                  child: Text('Vegetarian')),
            ],
            onChanged: (v) {
              if (v != null) onDietChanged(v);
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: waistCtrl,
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
                  controller: neckCtrl,
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
                  controller: hipCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Hip (cm)',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats Grid ────────────────────────────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  final UserProfile profile;
  const _StatsGrid({required this.profile});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Age', '${profile.age} yrs', '🎂'),
      ('Weight', '${profile.weight.toStringAsFixed(1)} kg', '⚖️'),
      ('Height', '${profile.height.round()} cm', '📏'),
      ('Activity',
          _actLabel(profile.activityLevel),
          '🏃'),
      ('Goal', _goalLabel(profile.goal), '🎯'),
      ('Diet', _dietLabel(profile.dietPreference), '🥗'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final (label, value, emoji) = items[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 4),
              Text(value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              Text(label,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 10)),
            ],
          ),
        );
      },
    );
  }

  String _actLabel(ActivityLevel l) {
    switch (l) {
      case ActivityLevel.sedentary: return 'Sedentary';
      case ActivityLevel.light: return 'Light';
      case ActivityLevel.moderate: return 'Moderate';
      case ActivityLevel.active: return 'Active';
    }
  }

  String _goalLabel(UserGoal g) {
    switch (g) {
      case UserGoal.lose: return 'Lose Fat';
      case UserGoal.maintain: return 'Maintain';
      case UserGoal.gain: return 'Gain Muscle';
    }
  }

  String _dietLabel(DietPreference d) {
    switch (d) {
      case DietPreference.normal: return 'Balanced';
      case DietPreference.highProtein: return 'Hi-Protein';
      case DietPreference.lowCarb: return 'Low Carb';
      case DietPreference.keto: return 'Keto';
      case DietPreference.pakistaniTraditional: return 'Pakistani';
      case DietPreference.vegetarian: return 'Vegetarian';
    }
  }
}

// ── Targets Card ──────────────────────────────────────────────────────────────
class _TargetsCard extends StatelessWidget {
  final UserProfile profile;
  const _TargetsCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Targets',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          const SizedBox(height: 16),
          _targetRow('🔥 Calories', '${profile.dailyCalorieTarget} kcal'),
          _targetRow('🥩 Protein', '${profile.dailyProteinTarget}g'),
          _targetRow('🍚 Carbs', '${profile.dailyCarbsTarget}g'),
          _targetRow('🫒 Fat', '${profile.dailyFatTarget}g'),
          const Divider(height: 24),
          _targetRow('🔥 BMR', '${profile.bmr.round()} kcal'),
          _targetRow('⚡ TDEE', '${profile.tdee.round()} kcal'),
        ],
      ),
    );
  }

  Widget _targetRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
        ],
      ),
    );
  }
}

// ── Privacy & data (Play Data safety alignment) ─────────────────────────────
class _PrivacyDataSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsOn = ref.watch(analyticsEnabledProvider);
    final privacy = ref.read(privacyPreferencesProvider);
    final stepTrackingOn = ref.watch(stepTrackingEnabledProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Privacy & data',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Firebase Analytics',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
            ),
            subtitle: const Text(
              'Off by default (Play compliance). Enable to send anonymous usage events only.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            value: analyticsOn,
            onChanged: (v) => privacy.setAnalyticsEnabled(v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Step tracking service',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
            ),
            subtitle: const Text(
              'Off by default. Enables background step tracking with a persistent notification.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            value: stepTrackingOn,
            onChanged: (v) async {
              final prefs = ref.read(sharedPreferencesProvider);
              await prefs.setBool(PrefsKeys.stepTrackingEnabled, v);
              ref.read(stepTrackingEnabledProvider.notifier).state = v;
              if (v) {
                // Native boot receiver reads from its own SharedPreferences store.
                // Keep it in sync by writing the same key there too (Android only).
                try {
                  if (defaultTargetPlatform == TargetPlatform.android) {
                    await const MethodChannel('pakfittrack/steps')
                        .invokeMethod('setEnabled', {'enabled': true});
                  }
                } catch (_) {}
                await ref.read(stepTrackerServiceProvider).start();
              } else {
                try {
                  if (defaultTargetPlatform == TargetPlatform.android) {
                    await const MethodChannel('pakfittrack/steps')
                        .invokeMethod('setEnabled', {'enabled': false});
                  }
                } catch (_) {}
                await ref.read(stepTrackerServiceProvider).stop();
              }
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.list_alt_outlined, color: AppColors.info),
            title: const Text('What data we collect',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted),
            onTap: () => context.push('/privacy-data'),
          ),
        ],
      ),
    );
  }
}

final stepTrackingEnabledProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(PrefsKeys.stepTrackingEnabled) ?? false;
});

// ── Settings ──────────────────────────────────────────────────────────────────
class _SettingsSection extends StatelessWidget {
  final VoidCallback onRedo;
  final VoidCallback onSignOut;
  final VoidCallback onDeleteAccount;

  const _SettingsSection({
    required this.onRedo,
    required this.onSignOut,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _settingsTile(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy Policy',
          subtitle: 'How we handle your data',
          color: AppColors.info,
          onTap: () => context.push('/legal/privacy'),
        ),
        const SizedBox(height: 10),
        _settingsTile(
          icon: Icons.description_outlined,
          label: 'Terms of Service',
          subtitle: 'Usage terms',
          color: AppColors.info,
          onTap: () => context.push('/legal/terms'),
        ),
        const SizedBox(height: 10),
        _settingsTile(
          icon: Icons.medical_information_outlined,
          label: 'Health Disclaimer',
          subtitle: 'Not medical advice',
          color: AppColors.warning,
          onTap: () => context.push('/legal/health'),
        ),
        const SizedBox(height: 10),
        _settingsTile(
          icon: Icons.refresh_rounded,
          label: 'Redo Onboarding',
          subtitle: 'Recalculate your targets',
          color: AppColors.info,
          onTap: onRedo,
        ),
        const SizedBox(height: 10),
        _settingsTile(
          icon: Icons.delete_forever_rounded,
          label: 'Delete account',
          subtitle: 'Submit a deletion request (processed manually)',
          color: AppColors.error,
          onTap: onDeleteAccount,
        ),
        const SizedBox(height: 10),
        _settingsTile(
          icon: Icons.logout_rounded,
          label: 'Sign Out',
          subtitle: 'Log out of your account',
          color: AppColors.textSecondary,
          onTap: onSignOut,
        ),
      ],
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Measurements Card ──────────────────────────────────────────────────────────
class _MeasurementsCard extends StatelessWidget {
  final UserProfile profile;
  const _MeasurementsCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Body Measurements 📏',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            'Body measurements are crucial to track real fat loss and muscle gain when the scale doesn\'t budge.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const Divider(height: 24),
          _measurementRow('Waist Circumference', profile.waistCm != null ? '${profile.waistCm?.toStringAsFixed(1)} cm' : 'Not set', '📏'),
          _measurementRow('Neck Circumference', profile.neckCm != null ? '${profile.neckCm?.toStringAsFixed(1)} cm' : 'Not set', '📿'),
          _measurementRow('Hip Circumference', profile.hipCm != null ? '${profile.hipCm?.toStringAsFixed(1)} cm' : 'Not set', '🍑'),
        ],
      ),
    );
  }

  Widget _measurementRow(String label, String value, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 14)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
        ],
      ),
    );
  }
}
