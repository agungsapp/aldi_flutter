import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF0770CD),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF0770CD),
          secondary: const Color(0xFF0099FF),
          surface: Colors.white,
          background: const Color(0xFFF8FAFE),
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0770CD),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0770CD),
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: const Color(0xFF0770CD).withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF0770CD),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF4DA6FF),
          secondary: const Color(0xFF66B3FF),
        ),
  );
}
