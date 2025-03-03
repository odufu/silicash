// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:silicash_mobile/app_runner.dart';
// import 'package:silicash_mobile/core/di/injection.dart';

// void main() {
//   setUpAll(() async {
//     TestWidgetsFlutterBinding.ensureInitialized();
//     await initializeDependencies();
//   });

//   tearDownAll(() async {
//     await sl.reset();
//   });

//   group('Silicash App Tests', () {
//     testWidgets('App should build without errors', (WidgetTester tester) async {
//       await tester.pumpWidget(const SilicashApp());
//       expect(find.byType(MaterialApp), findsOneWidget);
//     });

//     testWidgets('App should have correct theme', (WidgetTester tester) async {
//       await tester.pumpWidget(const SilicashApp());
//       final MaterialApp app = tester.widget(find.byType(MaterialApp));
//       expect(app.debugShowCheckedModeBanner, isFalse);
//       expect(app.title, equals('Silicash'));
//     });
//   });
// }
