import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../core/services/sync_service.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _obscure = true;
  bool _loading = false;
  bool _acceptedTerms = false;
  bool _showEmailForm = false;
  bool _postAuthNavigating = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterAuth() async {
    if (_postAuthNavigating) return;
    _postAuthNavigating = true;

    try {
      final user = ref.read(authStateProvider).valueOrNull ??
          ref.read(firebaseAuthProvider)?.currentUser;
      if (user == null) {
        if (!mounted) return;
        return;
      }
      if (user.emailVerified == false) {
        if (!mounted) return;
        context.go('/verify-email');
        return;
      }

      final profile = await ref
          .read(syncServiceProvider)
          .ensureUserProfile(user.uid)
          .timeout(const Duration(seconds: 8), onTimeout: () => null);
      if (!mounted) return;
      // First-time users fill "Tell us about yourself" before dashboard.
      // Returning users (reinstall) restore cloud profile and skip onboarding.
      if (profile?.onboardingComplete == true) {
        context.go('/dashboard');
      } else {
        context.go('/onboarding');
      }
    } finally {
      _postAuthNavigating = false;
    }
  }

  bool _ensureTermsAccepted() {
    if (_acceptedTerms) return true;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Please accept the Privacy Policy and Terms to continue.'),
        backgroundColor: AppColors.warning,
      ),
    );
    return false;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_ensureTermsAccepted()) return;
    setState(() => _loading = true);
    try {
      final notifier = ref.read(authNotifierProvider.notifier);
      if (_isLogin) {
        await notifier.signInWithEmail(
            _emailCtrl.text.trim(), _passwordCtrl.text);
      } else {
        await notifier.registerWithEmail(
            _emailCtrl.text.trim(), _passwordCtrl.text);
      }
      if (mounted) await _navigateAfterAuth();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your email above first')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(authNotifierProvider.notifier).sendPasswordReset(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent. Check your inbox.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(e.toString()), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    if (!_ensureTermsAccepted()) return;
    setState(() => _loading = true);
    try {
      final ok =
          await ref.read(authNotifierProvider.notifier).signInWithGoogle();
      if (!mounted) return;
      if (!ok) {
        // User cancelled Google picker — stay on auth screen.
        return;
      }
      await _navigateAfterAuth();
    } catch (e) {
      if (mounted) {
        final message = e.toString().replaceAll('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _termsCheckbox() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: CheckboxListTile(
        value: _acceptedTerms,
        onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'I agree to the ',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
            ),
            GestureDetector(
              onTap: () => context.push('/legal/privacy'),
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Text(
              ' and ',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
            ),
            GestureDetector(
              onTap: () => context.push('/legal/terms'),
              child: const Text(
                'Terms',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        subtitle: const Text(
          'Not medical advice. See Health Disclaimer in Profile.',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If auth resolves while still on this screen (e.g. after Google),
    // route to onboarding or dashboard — never leave new users stuck on login.
    ref.listen(authStateProvider, (prev, next) {
      if (_loading || _postAuthNavigating) return;
      final user = next.valueOrNull;
      if (user != null && user.emailVerified == true) {
        _navigateAfterAuth();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.surfaceLight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Pak Fit Track',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 40),

              const Text(
                'Sign in to continue 👋',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

              const SizedBox(height: 8),

              const Text(
                'Use your Google account to save progress securely across devices.',
                style:
                    TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ).animate().fadeIn(duration: 400.ms, delay: 150.ms),

              const SizedBox(height: 24),

              _termsCheckbox()
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 180.ms),

              const SizedBox(height: 16),

              // Primary: Google Sign-In with authentic Google branding
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1F2937),
                    elevation: 2,
                    shadowColor: Colors.black.withValues(alpha: 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFF1F2937),
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _GoogleLogoIcon(size: 22),
                            SizedBox(width: 12),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 220.ms),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 18),

              // Secondary: email form
              if (!_showEmailForm)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: _loading
                        ? null
                        : () => setState(() => _showEmailForm = true),
                    child: const Text('Use email instead'),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 260.ms)
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.surfaceLight),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _isLogin ? 'Log In with Email' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close_rounded, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () =>
                                  setState(() => _showEmailForm = false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Email required';
                            if (!v.contains('@')) return 'Invalid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Password required';
                            }
                            if (v.length < 6) return 'Minimum 6 characters';
                            return null;
                          },
                        ),
                        if (_isLogin) ...[
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _loading ? null : _forgotPassword,
                              child: const Text('Forgot password?'),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _submit,
                            child: _loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(_isLogin ? 'Log In' : 'Create Account'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLogin
                                  ? "Don't have an account? "
                                  : 'Already have an account? ',
                              style:
                                  const TextStyle(color: AppColors.textSecondary),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _isLogin = !_isLogin),
                              child: Text(
                                _isLogin ? 'Sign Up' : 'Log In',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => context.push('/legal/privacy'),
                  child: const Text(
                    'Privacy Policy & Terms',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Authentic 4-color Google "G" icon widget.
class _GoogleLogoIcon extends StatelessWidget {
  final double size;
  const _GoogleLogoIcon({this.size = 22});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double stroke = w * 0.22;
    final double cx = w / 2;
    final double cy = h / 2;
    final double r = (w - stroke) / 2;
    final Rect arcRect = Rect.fromCircle(center: Offset(cx, cy), radius: r);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    // Blue arc (bottom right to top right)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(arcRect, -0.5, 1.7, false, paint);

    // Green arc (bottom)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(arcRect, 1.2, 1.5, false, paint);

    // Yellow arc (left)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(arcRect, 2.7, 1.3, false, paint);

    // Red arc (top)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(arcRect, 4.0, 1.4, false, paint);

    // Horizontal blue bar
    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    final Rect bar = Rect.fromLTWH(
      cx - stroke * 0.15,
      cy - stroke / 2,
      w / 2 + stroke * 0.15,
      stroke,
    );
    canvas.drawRect(bar, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
