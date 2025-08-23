// file: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/config/routes/theme_cubit.dart';
import 'package:invoice_app/config/themes/dark_theme.dart';
import 'package:invoice_app/config/themes/light_theme.dart';
import 'package:invoice_app/core/mainScreen/screen/mainScreen.dart';
import 'package:invoice_app/core/onboarding_screen/firstScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

// MyApp is now much simpler!
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provide the ThemeCubit to the entire app.
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          // The MaterialApp rebuilds whenever the ThemeState changes.
          return MaterialApp(
            title: 'Invoice app',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode, // Set themeMode from the cubit's state
            home: Firstscreen(),
          );
        },
      ),
    );
  }
}
