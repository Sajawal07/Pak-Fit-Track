import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/prefs_keys.dart';
import '../../providers/auth_provider.dart';
import '../../core/services/sync_service.dart';
import '../../main.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  bool _loading = false;
  bool _checking = false;
  Timer? _pollTimer;
  Timer? _cooldownTimer;
  DateTime? _lastSentAt;
  int _cooldownSecondsLeft = 0;

  static const int _cooldownSeconds = 60;

  @override
  void initState() {
    super.initState();
    _loadInitialCooldown();
    // Gentle polling: stops automatically when screen is disposed.
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkVerified(silent: true);
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _loadInitialCooldown() {
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final ms = prefs.getInt(PrefsKeys.lastVerificationEmailSentAtMs);
      if (ms != null && ms > 0) {
        _lastSentAt = DateTime.fromMillisecondsSinceEpoch(ms);
      }
    } catch (_) {}
    _recomputeCooldownAndTick();
  }

  void _recomputeCooldownAndTick() {
    _cooldownTimer?.cancel();

    final last = _lastSentAt;
    if (last == null) {
      setState(() => _cooldownSecondsLeft = 0);
      return;
    }

    final elapsed = DateTime.now().difference(last).inSeconds;
    final left = (_cooldownSeconds - elapsed).clamp(0, _cooldownSeconds);
    setState(() => _cooldownSecondsLeft = left);
    if (left == 0) return;

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      final last2 = _lastSentAt;
      if (last2 == null) {
        setState(() => _cooldownSecondsLeft = 0);
        t.cancel();
        return;
      }
      final elapsed2 = DateTime.now().difference(last2).inSeconds;
      final left2 = (_cooldownSeconds - elapsed2).clamp(0, _cooldownSeconds);
      setState(() => _cooldownSecondsLeft = left2);
      if (left2 == 0) t.cancel();
    });
  }

  Future<void> _sendVerificationEmail() async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    // Basic rate limit (client-side UX only).
    if (_cooldownSecondsLeft > 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please wait $_cooldownSecondsLeft seconds before resending.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      await user.sendEmailVerification();
      final now = DateTime.now();
      _lastSentAt = now;
      try {
        final prefs = ref.read(sharedPreferencesProvider);
        await prefs.setInt(
          PrefsKeys.lastVerificationEmailSentAtMs,
          now.millisecondsSinceEpoch,
        );
      } catch (_) {}
      _recomputeCooldownAndTick();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent. Check your inbox/spam.'),
          backgroundColor: AppColors.success,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Failed to send verification email.'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _checkVerified({bool silent = false}) async {
    final auth = ref.read(firebaseAuthProvider);
    final user = auth?.currentUser;
    if (user == null) return;

    try {
      if (!silent && mounted) setState(() => _checking = true);
      await user.reload();
      final refreshed = auth?.currentUser;
      if (refreshed?.emailVerified == true) {
        // Proceed to app (onboarding or dashboard).
        final profile = await ref
            .read(syncServiceProvider)
            .ensureUserProfile(refreshed!.uid);
        if (!mounted) return;
        if (profile?.onboardingComplete == true) {
          context.go('/dashboard');
        } else {
          context.go('/onboarding');
        }
      } else if (!silent && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Not verified yet. Please check your email and try again.'),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    } catch (e) {
      if (!silent && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not refresh account status. Please try again. ($e)'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (!silent && mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;
    final email = user?.email ?? '';
    final canResend = !_loading && _cooldownSecondsLeft == 0;
    final resendLabel = _cooldownSecondsLeft > 0
        ? 'Resend in ${_cooldownSecondsLeft}s'
        : 'Resend verification email';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verify Email'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _loading
                ? null
                : () async {
                    await ref.read(authNotifierProvider.notifier).signOut();
                    if (context.mounted) context.go('/auth');
                  },
            child: const Text('Sign out'),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Check your inbox',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email.isNotEmpty
                    ? 'We sent a verification link to:\n$email'
                    : 'We sent a verification email. Please verify to continue.',
                style: const TextStyle(color: AppColors.textSecondary, height: 1.3),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'You can’t access the app until your email is verified.',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (_loading || _checking) ? null : () => _checkVerified(silent: false),
                  child: (_loading || _checking)
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text('I have verified'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: canResend ? _sendVerificationEmail : null,
                  child: Text(resendLabel),
                ),
              ),
              const Spacer(),
              const Text(
                'Tip: check Spam/Junk if you don’t see the email.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

