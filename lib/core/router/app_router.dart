import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silicash_mobile/core/utils/constants.dart';
import 'package:silicash_mobile/features/login/data/services/login_service.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/signup/pages/registration_flow.dart';
import '../../features/book_flight/presentation/pages/book_flight_page.dart';
import '../../features/book_flight/presentation/pages/flight_search_result_page.dart';
import '../../features/book_flight/presentation/pages/flight_details_page.dart';
import '../../features/book_flight/presentation/pages/checkoout_page.dart';
import '../../features/book_flight/presentation/pages/payment_confirmation_page.dart';
import '../pages/success_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: _buildRoutes(),
    errorBuilder: _errorBuilder,
  );

  static List<RouteBase> _buildRoutes() => [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) =>
              LoginPage(loginService: LoginService(Constants.baseUrl)),
        ),
        GoRoute(
          path: AppRoutes.signup,
          builder: (context, state) => RegistrationFlow(),
        ),
        GoRoute(
          path: AppRoutes.bookFlight,
          builder: (context, state) => BookFlightPage(),
        ),
        GoRoute(
          path: AppRoutes.flightSearchResults,
          builder: (context, state) => const FlightSearchResultsPage(),
        ),
        GoRoute(
          path: AppRoutes.flightDetails,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return FlightDetailsPage(
              flight: extra['flight'] as Map<String, dynamic>,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.checkout,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return CheckoutPage(
              flight: extra['flight'] as Map<String, dynamic>,
              departureDate: extra['departureDate'] as String,
              route: extra['route'] as String,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.paymentConfirmation,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return PaymentConfirmationPage(
              amount: extra['amount'] as String,
              balance: extra['balance'] as String,
              dateTime: extra['dateTime'] as String,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.success,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return SuccessScreen(
              title: extra['title'] as String,
              message: extra['message'] as String,
              gifPath: extra['gifPath'] as String,
              child: extra['child'] as Widget,
            );
          },
        ),
      ];

  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    );
  }
}
