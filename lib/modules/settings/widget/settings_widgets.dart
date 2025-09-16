import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/config/themes/cubit/theme_cubit.dart';

Widget buildSectionHeader(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
  );
}

Widget buildListTile(BuildContext context, IconData icon, String title, onTap) {
  return ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 16.0,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    onTap: onTap,
  );
}

Future<void> showThemePreferenceDialog(BuildContext context) async {
  // Get the current theme mode directly from the cubit
  final currentThemeMode = context.read<ThemeCubit>().state.themeMode;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      // 1. DECLARE THE VARIABLE HERE, OUTSIDE THE BUILDER
      ThemeMode selectedTheme = currentThemeMode;

      return StatefulBuilder(
        builder: (builderContext, setState) {
          // 2. The variable is NO LONGER declared inside here.
          //    It now correctly remembers the user's selection.
          return AlertDialog(
            title: const Text('App Preferences'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: selectedTheme,
                  title: const Text('Light'),
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: selectedTheme,
                  title: const Text('Dark'),
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: selectedTheme,
                  title: const Text('System Default'),
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  dialogContext.read<ThemeCubit>().updateTheme(selectedTheme);
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
  );
}
