import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[700],
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      color: Colors.blue[800],
      elevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue[700]!,
      secondary: Colors.amber[700]!,
      background: Colors.grey[100]!,
      surface: Colors.white,
      error: Colors.red[600]!,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.amber[700],
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo[400],
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.indigo[400]!,
      secondary: Colors.tealAccent[400]!,
      surface: Colors.grey[850]!,
      error: Colors.redAccent[200]!,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.tealAccent[400],
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.tealAccent[400],
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.grey[900],
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[850],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
     textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}