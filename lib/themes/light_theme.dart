import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.blueAccent,
    secondary: Colors.amber,
  ),
  cardColor: Colors.white,
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);
