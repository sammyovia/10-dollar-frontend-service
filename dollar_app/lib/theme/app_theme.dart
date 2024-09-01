import 'package:flutter/material.dart';

class AppTheme {
  // Define your color palette
  static const Color primaryColorLight = Color(0xFFD32F2F);
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color dividerColorLight = Color(0xFFBDBDBD);
  static const Color iconColorLight = Color(0xFF424242);

  static const Color primaryColorDark = Color(0xFFC62828);
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color dividerColorDark = Color(0xFF757575);
  static const Color iconColorDark = Color(0xFFE0E0E0);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    scaffoldBackgroundColor: backgroundColorLight,
    dividerColor: dividerColorLight,
    iconTheme: const IconThemeData(color: iconColorLight),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColorLight,
      iconTheme: IconThemeData(color: iconColorLight),
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColorLight,
      onPrimary: Colors.white,
      secondary: Colors.redAccent,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: backgroundColorDark,
    dividerColor: dividerColorDark,
    iconTheme: const IconThemeData(color: iconColorDark),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColorDark,
      iconTheme: IconThemeData(color: iconColorDark),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryColorDark,
      onPrimary: Colors.white,
      secondary: Colors.redAccent,
      onSecondary: Colors.white,
      surface: Color(0xFF222222),
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.black,
    ),
  );
}
