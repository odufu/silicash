import 'package:flutter/material.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';
import 'package:silicash_mobile/features/welcome/pages/welcome_page.dart';
import './core/theme/light_mode.dart';
import './features/splash_screen/pages/splash_screen4.dart';
import './features/splash_screen/pages/splash_screen5.dart';
import './features/splash_screen/pages/splash_screen3.dart';
import './features/splash_screen/pages/splash_screen2.dart';
import './features/splash_screen/pages/splash_screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silicash',
      theme: lightMode,
      home: WelcomePage(),
    );
  }
}
