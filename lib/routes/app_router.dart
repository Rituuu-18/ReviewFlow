import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/projects/presentation/projects_screen.dart';
import '../features/reviews/presentation/review_timeline_screen.dart';
import '../features/workspace/presentation/workspace_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/analytics/presentation/analytics_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Route error: ${state.error}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: '/timeline',
        builder: (context, state) => const ReviewTimelineScreen(),
      ),
      GoRoute(
        path: '/workspace',
        builder: (context, state) => const WorkspaceScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
}
