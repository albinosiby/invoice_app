import 'package:flutter/material.dart';

Widget buildSectionHeader(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    ),
  );
}

Widget buildListTile(BuildContext context, IconData icon, String title) {
  return ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.onBackground),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
    onTap: () {
      // Handle tile tap
    },
  );
}

// Future<void> showThemePreferenceDialog(BuildContext context, {String? currentTheme, required Function(String) onThemeSelected}) async {
//   await showDialog(
//     context: context,
//     builder: (context) {
//       String selectedTheme = currentTheme ?? 'system';
//       return AlertDialog(
//         title: Text('Select Theme Preference'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RadioListTile<String>(
//               value: 'light',
//               groupValue: selectedTheme,
//               title: Text('Light'),
//               onChanged: (value) {
//                 if (value != null) {
//                   selectedTheme = value;
//                   Navigator.of(context).pop();
//                   onThemeSelected(value);
//                 }
//               },
//             ),
//             RadioListTile<String>(
//               value: 'dark',
//               groupValue: selectedTheme,
//               title: Text('Dark'),
//               onChanged: (value) {
//                 if (value != null) {
//                   selectedTheme = value;
//                   Navigator.of(context).pop();
//                   onThemeSelected(value);
//                 }
//               },
//             ),
//             RadioListTile<String>(
//               value: 'system',
//               groupValue: selectedTheme,
//               title: Text('System'),
//               onChanged: (value) {
//                 if (value != null) {
//                   selectedTheme = value;
//                   Navigator.of(context).pop();
//                   onThemeSelected(value);
//                 }
//               },
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }
