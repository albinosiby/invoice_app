import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

Widget customButtonLarge(
  BuildContext context,
  String text,
  VoidCallback onPressed,
) {
  return SizedBox(
    width: 352,
    height: 52,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,

      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    ),
  );
}

Widget buildFilterChip(
  String label,
  bool isSelected,
  VoidCallback onPressed,
  context,
) {
  final theme = Theme.of(context);

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(84, 38),
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1, color: theme.colorScheme.surface),
      ),
      backgroundColor: isSelected
          ? theme.colorScheme.primary
          : theme.colorScheme.surface,
      foregroundColor: isSelected
          ? Colors.white
          : ThemeConfig.darkButtonTextDisabled,
    ),
    onPressed: onPressed,
    child: Center(
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: isSelected ? Colors.white : ThemeConfig.darkButtonTextDisabled,
        ),
      ),
    ),
  );
}

Widget customButtonSmall(
  BuildContext context,
  String text,
  VoidCallback onPressed,
) {
  return SizedBox(
    width: 169,
    height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    ),
  );
}

Widget smallButtton(context, text, onPressed, icon) {
  return SizedBox(
    width: 179,
    height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(icon, height: 23, width: 23),

          const SizedBox(width: 3),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}
