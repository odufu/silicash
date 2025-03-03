import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silicash_mobile/core/di/injection.dart';
import 'package:silicash_mobile/silicash.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Widget Tests', () {
    setUp(() async {
      await Silicash.initialize();
    });

    tearDown(() async {
      await sl.reset();
    });

    testWidgets('App builds successfully', (WidgetTester tester) async {
      // Build app
      await tester.pumpWidget(const SilicashApp(isTest: true));
      await tester.pumpAndSettle();

      // Basic structure test
      expect(find.byType(MaterialApp), findsOneWidget);

      // Get MaterialApp widget
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Basic configuration tests
      expect(app.debugShowCheckedModeBanner, isFalse);
      expect(app.title, equals('Silicash'));
    });
  });
}
