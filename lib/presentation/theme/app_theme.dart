import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Цветовая палитра ---
  static const _primaryNeonCyan = Color(0xFF00FFFF);
  static const _primaryDeepSpace = Color(0xFF0D0A24);
  static const _surfaceGlass = Color(0x1AFFFFFF);
  static const _accentMagenta = Color(0xFFFF00FF);
  static const _lightSeedColor = Colors.blue;

  // --- Базовая тема, от которой наследуются обе ---
  static final _baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.exo2().fontFamily,
  );

  // --- ТЕМНАЯ ТЕМА (Основная) ---
  static final ThemeData darkTheme = _baseTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _primaryDeepSpace,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryNeonCyan,
      brightness: Brightness.dark,
      primary: _primaryNeonCyan,
      secondary: _accentMagenta,
      background: _primaryDeepSpace,
      surface: _primaryDeepSpace,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.exo2(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _primaryNeonCyan,
      ),
      iconTheme: const IconThemeData(color: _primaryNeonCyan),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _primaryDeepSpace.withOpacity(0.8),
      selectedItemColor: _primaryNeonCyan,
      unselectedItemColor: Colors.grey[600],
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: _surfaceGlass,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _surfaceGlass),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryNeonCyan,
      foregroundColor: _primaryDeepSpace,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryNeonCyan,
        foregroundColor: _primaryDeepSpace,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: GoogleFonts.exo2(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: _baseTheme.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: _primaryNeonCyan,
    ),
  );

  // --- УЛУЧШЕННАЯ СВЕТЛАЯ ТЕМА ---
  static final ThemeData lightTheme = _baseTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade200,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _lightSeedColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _lightSeedColor,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: GoogleFonts.exo2(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _lightSeedColor,
      unselectedItemColor: Colors.grey[700],
      backgroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.amber[700],
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightSeedColor,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: GoogleFonts.exo2(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: _baseTheme.textTheme.apply(
      bodyColor: Colors.black87,
      displayColor: _lightSeedColor,
    ),
  );
}