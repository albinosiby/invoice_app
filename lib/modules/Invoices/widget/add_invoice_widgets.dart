import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

// add invoice widget

// Widget: Individual Item Row
Widget buildItemRow(
  String itemName,
  String details,
  String price,
  ThemeData theme,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            details,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: ThemeConfig.darkSecondaryText,
            ),
          ),
        ],
      ),
      Text(
        price,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    ],
  );
}

Widget buildPricingRow(icon, String label, String value, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Image.asset(
          icon,
          height: 24,
          width: 24,
          color: ThemeConfig.darkPrimaryAccent,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: ThemeConfig.darkPrimaryAccent,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );
}

// Widget: Price Row (for subtotal/total)
Widget buildPriceRow(
  String label,
  String value,
  ThemeData theme, {
  bool isTotal = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(
          label,
          style: isTotal
              ? theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                )
              : theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
        ),
        const Spacer(),
        Text(
          value,
          style: isTotal
              ? theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                )
              : theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
        ),
      ],
    ),
  );
}

Widget buildActionButton(
  String text,
  Color backgroundColor,
  Color textColor,
  VoidCallback onPressed,
  double width,
  context,
) {
  return SizedBox(
    width: width,
    height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: textColor),
      ),
    ),
  );
}
