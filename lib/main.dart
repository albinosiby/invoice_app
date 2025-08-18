import 'package:flutter/material.dart';
import 'package:invoice/config/themes/dark_theme.dart';
import 'package:invoice/config/themes/light_theme.dart';
import 'package:invoice/core/mainScreen/screen/mainScreen.dart';
import 'package:invoice/core/onboarding_screen/firstScreen.dart';
import 'package:invoice/modules/home/screen/home_Screen.dart';

void main() {
  runApp(const MyApp());
}

// This is the root of our application, which manages the theme state.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // We use ThemeMode.system by default to follow the OS theme.
  ThemeMode _themeMode = ThemeMode.system;

  // Toggles the theme between light and dark.
  void _toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light)
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  // Toggles the theme to follow the system settings.
  void _toggleSystemTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.system)
          ? ThemeMode.light
          : ThemeMode.system;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice app',
      debugShowCheckedModeBanner: false,
      // The light theme is defined in light_theme.dart
      theme: lightTheme,
      // The dark theme is defined in dark_theme.dart
      darkTheme: darkTheme,
      // The current theme mode is controlled by our state.
      themeMode: _themeMode,
      // We pass the theme toggling methods down to the HomePage.
      home: Firstscreen(),
    );
  }
}
