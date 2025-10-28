import 'package:flutter/material.dart';

class AppTheme {
  static const Color _lightPrimary = Color(0xFF007BFF);
  static const Color _darkPrimary = Color(0xFF90CAF9);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      secondary: Colors.amber,
    ),
    cardColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      secondary: Colors.orangeAccent,
    ),
    cardColor: const Color(0xFF1E1E1E),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
