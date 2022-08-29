import 'package:flutter/material.dart';

class AppTheme {
  static const double _elevation = 2;
  static const Color primary = Colors.indigo;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: _elevation,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primary),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: _elevation,
      backgroundColor: primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        elevation: _elevation,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: primary,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primary,
    appBarTheme: lightTheme.appBarTheme,
    scaffoldBackgroundColor: Colors.black,
    textButtonTheme: lightTheme.textButtonTheme,
    floatingActionButtonTheme: lightTheme.floatingActionButtonTheme,
    elevatedButtonTheme: lightTheme.elevatedButtonTheme,
  );
}
