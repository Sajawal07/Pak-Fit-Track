import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';

import '../../data/repositories/user_repository.dart';
import '../../main.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _minTimeElapsed = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _ctrl.forward();
    _startTimer();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _startTimer() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() {
      _minTimeElapsed = true;
    });
    _tryNavigate();
  }

  Future<void> _tryNavigate() async {
    if (!_minTimeElapsed || _navigated) return;
    
    final authBootstrapped = ref.read(authBootstrapCompleteProvider);
    if (!authBootstrapped) return; // Wait for the listener to call this again
    
    _navigated = true;

    final authState = ref.read(authStateProvider);
    final user = authState.value;

    if (user != null) {
      // UX-only: avoid a brief dashboard/onboarding flash for unverified users.
      // Router guard remains the authority for access control.
      if (user.emailVerified != true) {
        context.go('/verify-email');
        return;
      }
      final profile = await ref.read(userRepositoryProvider).getProfile(user.uid);
      if (!mounted) return;
      if (profile == null || !profile.onboardingComplete) {
        context.go('/onboarding');
      } else {
        context.go('/dashboard');
      }
    } else {
      // Check guest
      final prefs = ref.read(sharedPreferencesProvider);
      final guestUid = prefs.getString('guest_uid');
      if (guestUid != null) {
        final profile = await ref.read(userRepositoryProvider).getProfile(guestUid);
        if (!mounted) return;
        if (profile == null || !profile.onboardingComplete) {
          context.go('/onboarding');
        } else {
          context.go('/dashboard');
        }
      } else {
        if (!mounted) return;
        context.go('/auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(authBootstrapCompleteProvider, (prev, next) {
      if (next == true) {
        _tryNavigate();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            const Text(
              'Pak Fit Track',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            )
                .animate()
                .slideY(begin: 0.3, duration: 500.ms, delay: 200.ms)
                .fadeIn(duration: 500.ms, delay: 200.ms),

            const SizedBox(height: 8),

            const Text(
              'Pakistan\'s Smart Nutrition Tracker',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                letterSpacing: 0.2,
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms),

            const SizedBox(height: 60),

            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
