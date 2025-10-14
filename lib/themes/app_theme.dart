import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme with ChangeNotifier{
  
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;
  
}
