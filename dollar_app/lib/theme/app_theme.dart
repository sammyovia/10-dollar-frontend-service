import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF079697);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      dividerTheme: const DividerThemeData(color: Color(0xFFB2D8D8)),
      colorScheme: const ColorScheme.light(primary: _primaryColor));

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      dividerTheme: DividerThemeData(color: Colors.grey.shade300),
      colorScheme: const ColorScheme.dark(primary: _primaryColor)

      //colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor)
      );
}
