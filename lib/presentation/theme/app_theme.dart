import 'package:flutter/material.dart';

class AppTheme {
  // Основной цвет, из которого будут сгенерированы все остальные оттенки
  static const _seedColor = Colors.blue;

  // --- СВЕТЛАЯ ТЕМА ---
  static final ThemeData lightTheme = ThemeData(
    // Включаем современный дизайн Material 3
    useMaterial3: true,
    // Генерируем полную, согласованную цветовую схему
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    // Ниже можно переопределить стили для конкретных виджетов,
    // если сгенерированные по умолчанию не устраивают.
    appBarTheme: AppBarTheme(
      backgroundColor: _seedColor,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.amber[700],
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // --- ТЕМНАЯ ТЕМА ---
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    // Генерируем полную темную палитру из того же основного цвета
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark, // Главное отличие - яркость
    ),
    // Переопределяем стили для темной темы
    appBarTheme: AppBarTheme(
      elevation: 2,
      // В темной теме AppBar может иметь цвет фона по умолчанию,
      // сгенерированный из colorScheme.surface, что выглядит хорошо.
      // Но если нужно жестко задать, можно так:
      // backgroundColor: Colors.grey[900],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.tealAccent[400],
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}