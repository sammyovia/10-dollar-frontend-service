import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  AppThemeMode _appThemeMode = AppThemeMode.system;

  Future<void> _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final themeIndex = pref.getInt('app_theme_mode') ?? 2;
    _appThemeMode = AppThemeMode.values[themeIndex];
    _updateThemeMode();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('app_theme_mode', mode.index);
    _appThemeMode = mode;
    _updateThemeMode();
  }

  void _updateThemeMode() {
    switch (_appThemeMode) {
      case AppThemeMode.light:
        state = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        state = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        state = ThemeMode.system;
        break;
    }
  }

  AppThemeMode get appThemeMode => _appThemeMode;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
