import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.tealAccent,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.dark(
    primary: Colors.tealAccent,
    secondary: Colors.orangeAccent,
  ),
  cardColor: const Color(0xFF1E1E1E),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);
