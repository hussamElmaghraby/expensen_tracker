import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: const Color(0xFF4B39EF),
      scaffoldBackgroundColor: const Color(0xFFF1F4F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF4B39EF),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF101213),
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Color(0xFF57636C),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF4B39EF),
      ),
    );
  }
}
