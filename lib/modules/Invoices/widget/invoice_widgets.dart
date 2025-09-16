import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

Widget buildInvoiceCard(
  ThemeData theme,
  String clientName,
  String invoiceNumber,
  double amount,
  DateTime dueDate,
  String status,
  VoidCallback onRecordPayment,
) {
  final bool isPaid = status.toLowerCase() == 'paid';

  return SizedBox(
    height: 155,
    width: 354,
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: theme.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: theme.colorScheme.surface),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(clientName, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoiceNumber,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: ThemeConfig.darkButtonTextDisabled,
                  ),
                ),
                Text(
                  '₹ ${amount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(dueDate),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: ThemeConfig.darkButtonTextDisabled,
                  ),
                ),
                Text(
                  status,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(status),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: isPaid ? null : onRecordPayment,
                  child: Text(
                    isPaid ? 'Payment Recorded' : 'Record payment',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isPaid
                          ? ThemeConfig.darkButtonTextDisabled
                          : const Color.fromARGB(255, 163, 95, 211),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  color: theme.colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

String _formatDate(DateTime date) {
  return '${date.day} ${_getMonthName(date.month)} ${date.year}';
}

String _getMonthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'paid':
      return ThemeConfig.success;
    case 'pending':
      return ThemeConfig.warning;
    case 'overdue':
      return ThemeConfig.error;
    default:
      return ThemeConfig.darkButtonTextDisabled;
  }
}
