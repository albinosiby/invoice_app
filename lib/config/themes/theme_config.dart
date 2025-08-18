import 'package:flutter/material.dart';

// This file centralizes all the theme-related constants from your provided color palettes.
class ThemeConfig {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurfaceOrCard = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF111827);
  static const Color lightSecondaryText = Color(0xFF6B7280);
  static const Color lightBorderOrDivider = Color(0xFFE5E7EB);
  static const Color lightPlaceholderText = Color(0xFF9CA3AF);
  static const Color lightButtonDisabled = Color(0xFFE5E7EB);
  static const Color lightButtonTextDisabled = Color(0xFF9CA3AF);
  static const Color lightFormColumn = Color(0xFFEBEDF2);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurfaceOrCard = Color(0xFF1E1E1E);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFF6B7280);
  static const Color darkBorderOrDivider = Color(0xFFE5E7EB);
  static const Color darkPlaceholderText = Color(0xFF9CA3AF);
  static const Color darkButtonDisabled = Color(0xFF3C3C3C);
  static const Color darkButtonTextDisabled = Color(0xFF9CA3AF);
  static const Color darkFormColumn = Color(0xFF2C2C2C);

  // Shared/Accent Colors (Same in both themes)
  static const Color lightPrimaryAccent = Color(
    0xFF2563EB,
  ); // Updated to be specific for light theme
  static const Color darkPrimaryAccent = Color(
    0xFF60A5FA,
  ); // Updated to be specific for dark theme
  static const Color secondaryAccent = Color(0xFF6366F1);
  static const Color buttonTextPrimary = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  static const Color navIconActive = Color(0xFF60A5FA);
  static const Color navIconInactive = Color(0xFF9CA3AF);
}
