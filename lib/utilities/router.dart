import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presetup/screens/dashboard_screen.dart';
import 'package:presetup/screens/login_screen.dart';
import 'package:presetup/screens/splash_screen.dart';

// GoRouter configuration
final router = GoRouter(
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
        child: const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      ),
    ),
  ],
);
