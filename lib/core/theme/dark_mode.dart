import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF5E9024), // Maintain brand color
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B1B1B), // Darker app bar for better contrast
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF5E9024), // Brand green remains consistent
      onPrimary: Colors.white,
      secondary: Color(0xFFA5C732), // Muted version of light theme's secondary
      onSecondary: Colors.black,
      tertiary: Color(0xFF2D4210), // Darker tertiary variant
      onTertiary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: Color(0xFF1E1E1E), // Dark surface color
      onSurface: Color(0xFFE0E0E0), // Light text on dark surfaces
    ),
    textTheme: GoogleFonts.ralewayTextTheme().apply(
      bodyColor: const Color(0xFFE0E0E0),
      displayColor: const Color(0xFFE0E0E0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5E9024), // Maintain brand color
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xFF5E9024)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      labelStyle: const TextStyle(color: Color(0xFF5E9024)),
    ));
