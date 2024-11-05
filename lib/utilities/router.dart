import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/screens/dashboard_screen/main_dashboard_screen.dart';
import 'package:presetup/screens/login_screen/login_screen.dart';
import 'package:presetup/screens/splash_screen.dart';
import 'package:presetup/utilities/router_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// GoRouter configuration
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    refreshListenable:
        RouterRefresh(ref.watch(authRepositoryProvider).authStateChanges()),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = ref.watch(authRepositoryProvider).currentUser != null;
      if (isLoggedIn) {
        if (state.uri.toString().startsWith('/login')) {
          return '/home/dashboard';
        }
      } else {
        if (state.uri.toString().startsWith('/home')) {
          return '/login';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home/dashboard',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const MainDashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );
});
