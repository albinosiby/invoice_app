import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

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

Widget upComingDue(
  ThemeData theme,
  String clientName,
  String invoiceNumber,
  String amount,
  String status,
  String daysDue,
  String dueDate,
  VoidCallback onRecordManually, // New parameter
  VoidCallback onSendReminder, // New parameter
) {
  return SizedBox(
    // ... (Container and other widgets are the same)
    height: 160, // Increased height slightly to ensure no overflow
    width: 354,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        // ... (The top part of the card is the same)
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
          const Spacer(), // Use a Spacer to push the buttons to the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onRecordManually, // Use the callback here
                child: Text(
                  'Record Manually',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: ThemeConfig.info,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSendReminder, // Use the callback here
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
