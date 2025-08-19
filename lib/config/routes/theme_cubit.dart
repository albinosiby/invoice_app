// file: lib/core/theme/cubit/theme_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.system)) {
    _loadTheme(); // Load the saved theme on startup
  }

  static const String _themePreferenceKey = 'theme_preference';

  // Load the theme from SharedPreferences
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex =
        prefs.getInt(_themePreferenceKey) ?? 0; // Default to system
    final themeMode = ThemeMode.values[themeIndex];
    emit(ThemeState(themeMode));
  }

  // Update the theme and save the preference
  void updateTheme(ThemeMode themeMode) async {
    emit(ThemeState(themeMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, themeMode.index);
  }
}
