import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme_extension.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF5E9024),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5E9024),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF5E9024),
    onPrimary: Colors.white,
    secondary: const Color(0xFFCFE939),
    onSecondary: Colors.white,
    tertiary: const Color(0xFF365314),
    onTertiary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 232, 239, 223),
    onSurface: Colors.grey.shade800,
    // Add these required fields
    background: Colors.white,
    onBackground: Colors.black,
    outline: Colors.grey,
    shadow: Colors.grey,
  ),
  textTheme: GoogleFonts.ralewayTextTheme(),
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
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: Color(0xFF5E9024)),
    ),
  ),
  // Add the theme extension
  extensions: <ThemeExtension<dynamic>>[
    const AppThemeExtension(
      lightCardColor:
          Color.fromARGB(255, 255, 255, 255), // Your custom card color
      darkCardColor: Color.fromARGB(255, 39, 39, 39), // Your custom card color
    ),
  ],
);
