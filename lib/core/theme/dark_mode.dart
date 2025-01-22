import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF5E9024), // Main green color
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5E9024), // Matches the primary color
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: const Color.fromARGB(255, 0, 0, 0), // Bright green
    onPrimary: Colors.white, // Text/icons on primary
    secondary: const Color.fromARGB(255, 28, 32, 7), // Accent yellow-green
    onSecondary: Colors.white, // Text/icons on secondary
    tertiary: const Color.fromARGB(255, 0, 0, 0), // Dark green for tertiary use
    onTertiary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: const Color.fromARGB(255, 0, 0, 0), // Light surface color
    onSurface: Colors.grey.shade800,
  ),
  textTheme: GoogleFonts.ralewayTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5E9024), // Button background color
      foregroundColor: Colors.white, // Button text color
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);
