import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static void navigateToFlightSearch(BuildContext context) {
    context.go('/book-flight');
  }

  static void navigateToFlightSearchResults(BuildContext context, Map<String, dynamic> searchParams) {
    context.go('/flight-search-results', extra: searchParams);
  }

  static void navigateToFlightDetails(
    BuildContext context, {
    required Map<String, dynamic> flight,
    required DateTime departureDate,
    required String route,
  }) {
    context.go('/flight-details', extra: {
      'flight': flight,
      'departureDate': departureDate,
      'route': route,
    });
  }

  static void navigateToCheckout(
    BuildContext context, {
    required Map<String, dynamic> flight,
    required DateTime departureDate,
    required String route,
  }) {
    context.go('/checkout', extra: {
      'flight': flight,
      'departureDate': departureDate,
      'route': route,
    });
  }

  static void navigateToPaymentConfirmation(
    BuildContext context, {
    required double amount,
    required double balance,
    required DateTime dateTime,
  }) {
    context.go('/payment-confirmation', extra: {
      'amount': amount,
      'balance': balance,
      'dateTime': dateTime,
    });
  }

  static void navigateToSuccess(
    BuildContext context, {
    required String title,
    required String message,
    required String gifPath,
    required Widget child,
  }) {
    context.go('/success', extra: {
      'title': title,
      'message': message,
      'gifPath': gifPath,
      'child': child,
    });
  }

  static void navigateToLogin(BuildContext context) {
    context.go('/login');
  }

  static void navigateToSignup(BuildContext context) {
    context.go('/signup');
  }
}
