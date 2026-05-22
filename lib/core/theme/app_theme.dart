import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF6F7FB),
    primaryColor: const Color(0xFF0F766E),
    cardColor: Colors.white,
    useMaterial3: true,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );

static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0B1220),
    primaryColor: const Color(0xFF14B8A6),
    useMaterial3: true,
    fontFamily: 'Inter',
  );
}