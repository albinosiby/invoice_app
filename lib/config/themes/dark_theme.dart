import 'package:flutter/material.dart';
import 'theme_config.dart';

// Define the dark theme using constants from ThemeConfig.
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: MaterialColor(ThemeConfig.darkPrimaryAccent.value, {
    50: ThemeConfig.darkPrimaryAccent.withOpacity(0.1),
    100: ThemeConfig.darkPrimaryAccent.withOpacity(0.2),
    200: ThemeConfig.darkPrimaryAccent.withOpacity(0.3),
    300: ThemeConfig.darkPrimaryAccent.withOpacity(0.4),
    400: ThemeConfig.darkPrimaryAccent.withOpacity(0.5),
    500: ThemeConfig.darkPrimaryAccent.withOpacity(0.6),
    600: ThemeConfig.darkPrimaryAccent.withOpacity(0.7),
    700: ThemeConfig.darkPrimaryAccent.withOpacity(0.8),
    800: ThemeConfig.darkPrimaryAccent.withOpacity(0.9),
    900: ThemeConfig.darkPrimaryAccent,
  }),
  colorScheme: ColorScheme.dark(
    background: ThemeConfig.darkBackground,
    onBackground: ThemeConfig.darkPrimaryText,
    primary: ThemeConfig.darkPrimaryAccent,
    onPrimary: ThemeConfig.buttonTextPrimary,
    secondary: ThemeConfig.secondaryAccent,
    surface: ThemeConfig.darkSurfaceOrCard,
    onSurface: ThemeConfig.darkPrimaryText,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeConfig.darkSurfaceOrCard,
    foregroundColor: ThemeConfig.buttonTextPrimary,
  ),
  disabledColor: ThemeConfig.darkSecondaryText,
  scaffoldBackgroundColor: ThemeConfig.darkBackground,
  cardColor: ThemeConfig.darkSurfaceOrCard,
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
