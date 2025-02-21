import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme_extension.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF5E9024),
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF5E9024),
    onPrimary: Colors.white,
    secondary: const Color(0xFFCFE939),
    onSecondary: Colors.black,
    tertiary: const Color(0xFF365314),
    onTertiary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: const Color(0xFF1E1E1E),
    onSurface: Colors.grey.shade300,
    background: const Color(0xFF121212),
    onBackground: Colors.white,
    outline: Colors.grey.shade600,
    shadow: Colors.black,
  ),
  textTheme: GoogleFonts.ralewayTextTheme(ThemeData.dark().textTheme),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5E9024),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderSide: BorderSide(width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: Colors.grey.shade600),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: Color(0xFF5E9024)),
    ),
  ),
  // Add the theme extension
  extensions: <ThemeExtension<dynamic>>[
    const AppThemeExtension(
      lightCardColor: Color.fromARGB(255, 255, 255, 255),
      darkCardColor: Color.fromARGB(255, 39, 39, 39),
    ),
  ],
);
