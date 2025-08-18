import 'package:flutter/material.dart';
import 'theme_config.dart';

// Define the light theme using constants from ThemeConfig.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(ThemeConfig.lightPrimaryAccent.value, {
    50: ThemeConfig.lightPrimaryAccent.withOpacity(0.1),
    100: ThemeConfig.lightPrimaryAccent.withOpacity(0.2),
    200: ThemeConfig.lightPrimaryAccent.withOpacity(0.3),
    300: ThemeConfig.lightPrimaryAccent.withOpacity(0.4),
    400: ThemeConfig.lightPrimaryAccent.withOpacity(0.5),
    500: ThemeConfig.lightPrimaryAccent.withOpacity(0.6),
    600: ThemeConfig.lightPrimaryAccent.withOpacity(0.7),
    700: ThemeConfig.lightPrimaryAccent.withOpacity(0.8),
    800: ThemeConfig.lightPrimaryAccent.withOpacity(0.9),
    900: ThemeConfig.lightPrimaryAccent,
  }),
  colorScheme: ColorScheme.light(
    background: ThemeConfig.lightBackground,
    onBackground: ThemeConfig.lightPrimaryText,
    primary: ThemeConfig.lightPrimaryAccent,
    onPrimary: ThemeConfig.buttonTextPrimary,
    secondary: ThemeConfig.secondaryAccent,
    surface: ThemeConfig.lightSurfaceOrCard,
    onSurface: ThemeConfig.lightPrimaryText,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeConfig.lightSurfaceOrCard,
    foregroundColor: ThemeConfig.buttonTextPrimary,
  ),
  disabledColor: ThemeConfig.lightSecondaryText,
  scaffoldBackgroundColor: ThemeConfig.lightBackground,
  cardColor: ThemeConfig.lightSurfaceOrCard,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 1.5,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: 24,
      height: 1.5,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.5,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 20,
      height: 1.5,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 1.5,
    ),
  ),
);
