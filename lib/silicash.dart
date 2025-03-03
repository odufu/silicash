import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/dark_mode.dart';
import 'features/signup/provider/registration_provider.dart';
import 'features/authentication/provider/auth_provider.dart';

class SilicashApp extends StatelessWidget {
  final bool isTest;
  
  const SilicashApp({
    super.key,
    this.isTest = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  Widget _buildApp() {
    final baseApp = MaterialApp.router(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: 'Silicash',
      theme: darkMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );

    final withProviders = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => inject<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ],
      child: baseApp,
    );

    if (isTest) {
      return withProviders;
    }

    return DevicePreview(
      builder: (context) => withProviders,
    );
  }
}

class Silicash {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDependencies();
  }

  static void run() {
    runApp(const SilicashApp());
  }

  static Future<void> start() async {
    await initialize();
    run();
  }
}
