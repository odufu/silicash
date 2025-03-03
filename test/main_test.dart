// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:silicash_mobile/core/di/injection.dart';

// void main() {
//   group('Main App Tests', () {
//     setUp(() async {
//       TestWidgetsFlutterBinding.ensureInitialized();
//       await initializeDependencies();
//     });

//     tearDown(() async {
//       await sl.reset();
//     });

//     testWidgets('App initializes correctly', (WidgetTester tester) async {
//       // Build our app and trigger a frame
//       await tester.pumpWidget(const SilicashApp());

//       // Verify that the app builds with MaterialApp.router
//       expect(find.byType(MaterialApp.router), findsOneWidget);

//       // Get the MaterialApp.router widget
//       final app = tester.widget<MaterialApp.router>(find.byType(MaterialApp.router));

//       // Verify app configuration
//       expect(app.debugShowCheckedModeBanner, isFalse);
//       expect(app.title, equals('Silicash'));
//       expect(app.routerConfig, isNotNull);
//       expect(app.theme, isNotNull);
//       expect(app.darkTheme, isNotNull);
//     });
//   });
// }
