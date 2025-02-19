import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/dark_mode.dart';
import 'package:silicash_mobile/features/airtime/pages/mobile_top_up.dart';
import 'package:silicash_mobile/features/signup/provider/registration_provider.dart';
import './core/theme/light_mode.dart';
import './features/splash_screen/pages/splash_screen1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        // Add other providers here if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silicash',
      theme: lightMode,
      home: SplashScreen(),
    );
  }
}
