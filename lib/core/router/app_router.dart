import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/auth/auth_screen.dart';
import '../../presentation/auth/verify_email_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/dashboard/dashboard_screen.dart';
import '../../presentation/nutrition/food_search_screen.dart';
import '../../presentation/nutrition/add_food_screen.dart';
import '../../presentation/activity/activity_screen.dart';
import '../../presentation/analytics/analytics_screen.dart';
import '../../presentation/weight/weight_screen.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/main_shell.dart';
import '../../data/models/food_item.dart';
import '../../presentation/notifications/notifications_screen.dart';
import '../../presentation/profile/legal_screen.dart';
import '../../presentation/profile/data_collection_screen.dart';

/// Stable GoRouter — auth changes refresh redirects without recreating the router
/// (recreating was resetting navigation to /splash and causing hangs).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);

  ref.listen(authStateProvider, (_, __) => refresh.value++);
  ref.listen(authBootstrapCompleteProvider, (_, __) => refresh.value++);

  final router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final authState = ref.read(authStateProvider);
      final authBootstrapped = ref.read(authBootstrapCompleteProvider);

      if (loc.startsWith('/legal') || loc == '/privacy-data') {
        return null;
      }

      // Wait for first auth emission before leaving splash / guarding routes.
      if (!authBootstrapped || authState.isLoading) {
        return loc == '/splash' ? null : '/splash';
      }

      final user = authState.valueOrNull;
      final isLoggedIn = user != null;
      final isVerified = user?.emailVerified == true;
      final isAuthRoute = loc == '/auth';
      final isVerifyRoute = loc == '/verify-email';
      final isSplash = loc == '/splash';

      // Not signed in → auth only (no guest access).
      if (!isLoggedIn) {
        if (isAuthRoute) return null;
        // Splash navigates itself after min delay; fall back to auth if still here.
        if (isSplash) return null;
        return '/auth';
      }

      // Signed in, email not verified.
      if (!isVerified) {
        if (isVerifyRoute) return null;
        if (isSplash) return null;
        return '/verify-email';
      }

      // Signed in + verified:
      // Never force /dashboard from here — new users must complete onboarding
      // ("Tell us about yourself") first. Splash / AuthScreen decide the target.
      if (isAuthRoute || isVerifyRoute) {
        return null;
      }
      if (isSplash) return null;

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (ctx, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (ctx, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (ctx, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (ctx, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (ctx, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (ctx, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/activity',
            builder: (ctx, state) => const ActivityScreen(),
          ),
          GoRoute(
            path: '/analytics',
            builder: (ctx, state) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: '/weight',
            builder: (ctx, state) => const WeightScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (ctx, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/food-search',
        builder: (ctx, state) => const FoodSearchScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (ctx, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/add-food',
        builder: (ctx, state) {
          final extra = state.extra;
          if (extra is! FoodItem) {
            return const Scaffold(
              body: Center(child: Text('Food item not found')),
            );
          }
          return AddFoodScreen(food: extra);
        },
      ),
      GoRoute(
        path: '/legal/privacy',
        builder: (ctx, state) =>
            const LegalScreen(type: LegalPageType.privacy),
      ),
      GoRoute(
        path: '/legal/terms',
        builder: (ctx, state) => const LegalScreen(type: LegalPageType.terms),
      ),
      GoRoute(
        path: '/legal/health',
        builder: (ctx, state) =>
            const LegalScreen(type: LegalPageType.healthDisclaimer),
      ),
      GoRoute(
        path: '/privacy-data',
        builder: (ctx, state) => const DataCollectionScreen(),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });

  return router;
});
