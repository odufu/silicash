import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

final List<RouteBase> appRoutes = [
  GoRoute(
    path: AppRoutes.splash,
    builder: (context, state) => const _PlaceholderScreen(title: 'Splash'),
  ),
  GoRoute(
    path: AppRoutes.login,
    builder: (context, state) => const _PlaceholderScreen(title: 'Login'),
  ),
  GoRoute(
    path: AppRoutes.signup,
    builder: (context, state) => const _PlaceholderScreen(title: 'Sign Up'),
  ),
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const _PlaceholderScreen(title: 'Home'),
  ),
  GoRoute(
    path: AppRoutes.bookFlight,
    builder: (context, state) => const _PlaceholderScreen(title: 'Book Flight'),
  ),
  GoRoute(
    path: AppRoutes.flightSearch,
    builder: (context, state) => const _PlaceholderScreen(title: 'Flight Search'),
  ),
  GoRoute(
    path: AppRoutes.flightDetails,
    builder: (context, state) => const _PlaceholderScreen(title: 'Flight Details'),
  ),
  GoRoute(
    path: AppRoutes.checkout,
    builder: (context, state) => const _PlaceholderScreen(title: 'Checkout'),
  ),
  GoRoute(
    path: AppRoutes.paymentConfirmation,
    builder: (context, state) => const _PlaceholderScreen(title: 'Payment Confirmation'),
  ),
  GoRoute(
    path: AppRoutes.success,
    builder: (context, state) => const _PlaceholderScreen(title: 'Success'),
  ),
];

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title Screen'),
      ),
    );
  }
}
