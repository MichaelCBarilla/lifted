import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifted/src/features/authentication/data/fake_auth_repository.dart';
import 'package:lifted/src/features/authentication/presentation/account/account_screen.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:lifted/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:lifted/src/features/workouts/presentation/workout_screen/workout_screen.dart';
import 'package:lifted/src/features/workouts/presentation/workouts_list/workouts_list_screen.dart';
import 'package:lifted/src/routing/go_router_refresh_stream.dart';
import 'package:lifted/src/routing/not_found_screen.dart';

enum AppRoute {
  home,
  workout,
  account,
  signIn,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
      } else {
        return '/signIn';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const WorkoutsListScreen(),
        routes: [
          GoRoute(
            path: 'workout/:id',
            name: AppRoute.workout.name,
            builder: (context, state) {
              final workoutId = state.pathParameters['id']!;
              return WorkoutScreen(workoutId: workoutId);
            },
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
