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

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final authBootstrapped = ref.watch(authBootstrapCompleteProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (loc == '/splash' ||
          loc.startsWith('/legal') ||
          loc == '/privacy-data') {
        return null;
      }

      // Only block on auth loading during initial bootstrap — not on every rebuild.
      if (!authBootstrapped && authState.isLoading) return '/splash';

      final user = authState.value;
      final isLoggedIn = user != null;
      final isVerified = user?.emailVerified == true;

      // Public routes
      final isAuthRoute = loc == '/auth';
      final isVerifyRoute = loc == '/verify-email';
      final guestAllowed = <String>{
        '/onboarding',
        '/dashboard',
        '/activity',
        '/analytics',
        '/weight',
        '/profile',
        '/food-search',
        '/add-food',
        '/notifications',
      };

      // If not logged in, block protected routes.
      if (!isLoggedIn) {
        if (isAuthRoute) return null;
        if (isVerifyRoute) return '/auth';
        // Guest users: full UI access; cloud sync/auth routes remain available separately.
        if (guestAllowed.contains(loc)) return null;
        return '/dashboard';
      }

      // Logged in but not verified: force verification screen.
      if (!isVerified) {
        if (isVerifyRoute) return null;
        // Allow legal screens already handled above.
        return '/verify-email';
      }

      // Logged in + verified: don't allow auth/verify screens.
      if (isAuthRoute || isVerifyRoute) {
        return '/dashboard';
      }

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
});
