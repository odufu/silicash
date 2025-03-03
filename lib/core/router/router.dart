import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../../features/authentication/provider/auth_provider.dart';
import 'app_routes.dart';
import 'routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: appRoutes,
  redirect: (context, state) {
    final authProvider = inject<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;
    final path = state.uri.path;

    // Allow access to splash screen
    if (path == AppRoutes.splash) return null;

    // If not logged in and not on auth routes, redirect to login
    if (!isLoggedIn && 
        path != AppRoutes.login && 
        path != AppRoutes.signup) {
      return AppRoutes.login;
    }

    // If logged in and on auth routes, redirect to home
    if (isLoggedIn && 
        (path == AppRoutes.login || path == AppRoutes.signup)) {
      return AppRoutes.home;
    }

    // Allow access to current route
    return null;
  },
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
