import 'package:flutter/material.dart';
import 'package:invoice/config/themes/theme_config.dart';

Widget dashboardCard(
  theme,
  IconData iconCode,
  title,
  value,
  subtitle,
  color,
  iconcolor,
) {
  return SizedBox(
    height: 110,
    width: 159,
    child: Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconCode, color: iconcolor, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.labelSmall?.copyWith(
              color: ThemeConfig.darkButtonTextDisabled,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget smallButtton(context, text, onPressed) {
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
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    ),
  );
}

Widget upComingDue(
  theme,
  clientName,
  invoiceNumber,
  amount,
  status,
  daysDue,
  dueDate,
) {
  return SizedBox(
    height: 130,
    width: 354,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(clientName, style: theme.textTheme.titleMedium),
              Text(amount, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            invoiceNumber,
            style: theme.textTheme.bodySmall?.copyWith(
              color: ThemeConfig.darkButtonTextDisabled,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$dueDate | $daysDue',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: ThemeConfig.darkButtonTextDisabled,
                ),
              ),
              Text(
                status,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: ThemeConfig.warning,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Add your logic for "Record Manually" here.
                },
                child: Text(
                  'Record Manually',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: ThemeConfig.info,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add your logic for "Send Reminder" here.
                },
                child: Text(
                  'Send Reminder',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: ThemeConfig.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
