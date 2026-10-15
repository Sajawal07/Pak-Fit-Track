import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../core/services/sync_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _minTimeElapsed = false;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _ctrl.forward();
    _startTimer();
    // Safety net if Firebase/profile is slow.
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted && !_navigating) _routeNow(force: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _startTimer() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _minTimeElapsed = true);
    await _routeNow();
  }

  Future<void> _routeNow({bool force = false}) async {
    if (!mounted || _navigating) return;
    if (!_minTimeElapsed && !force) return;

    final bootstrapped = ref.read(authBootstrapCompleteProvider);
    if (!bootstrapped && !force) return;

    // Prefer live Firebase user — more reliable on cold start than stream lag.
    final user = ref.read(firebaseAuthProvider)?.currentUser ??
        ref.read(authStateProvider).valueOrNull;

    if (user == null) {
      if (!bootstrapped && !force) return;
      _navigating = true;
      if (mounted) context.go('/auth');
      return;
    }

    if (user.emailVerified != true) {
      _navigating = true;
      if (mounted) context.go('/verify-email');
      return;
    }

    _navigating = true;
    try {
      // Restore cloud profile on reinstall before deciding onboarding.
      final profile = await ref
          .read(syncServiceProvider)
          .ensureUserProfile(user.uid)
          .timeout(const Duration(seconds: 8));
      if (!mounted) return;
      if (profile == null || !profile.onboardingComplete) {
        context.go('/onboarding');
      } else {
        context.go('/dashboard');
      }
    } catch (_) {
      // Returning signed-in user: don't trap on splash if profile read fails.
      if (!mounted) return;
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(authBootstrapCompleteProvider, (prev, next) {
      if (next) _routeNow();
    });
    ref.listen(authStateProvider, (prev, next) {
      if (!next.isLoading) _routeNow();
    });

    if (ref.watch(authBootstrapCompleteProvider) &&
        _minTimeElapsed &&
        !_navigating) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _routeNow());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
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
            ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
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
