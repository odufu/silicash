import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 29, 3, 3),
      onPrimary: const Color.fromARGB(255, 255, 232, 232),
      secondary: const Color.fromARGB(255, 244, 126, 0),
      tertiary: const Color.fromARGB(255, 110, 55, 0),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.grey.shade100,
      onSurface: Colors.grey.shade700),
);
