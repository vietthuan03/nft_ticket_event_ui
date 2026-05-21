import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xff6351ec),
    scaffoldBackgroundColor: Color(0xfff1f3ff), //background color
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xff6351ec),
      secondary: Color(0xffe3e6ff),
      surface: Colors.white,
      onPrimary: Colors.white, //onBackground
      onSecondary: Colors.black,
      onSurface: Colors.black,
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black87),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xff6351ec)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff7d6df3),
    scaffoldBackgroundColor: Color(0xff121212),
    appBarTheme: AppBarTheme(
      color: Color(0xff1e1e1e),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xff7d6df3),
      secondary: Color(0xff2a2d3e),
      surface: Color(0xff1e1e1e),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    cardColor: const Color(0xFF1E1E1E),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white70),
      titleMedium: TextStyle(color: Colors.white, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xff7d6df3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xff7d6df3)),
      ),
    ),
  );
}
