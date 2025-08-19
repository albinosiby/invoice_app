import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/modules/Invoices/model/invoice_model.dart';

Widget invoiceCard(
  ThemeData theme,
  Invoice invoice,
  VoidCallback onRecordPayment,
  VoidCallback moreDotClicked,
) {
  final bool isPaid = invoice.status.toLowerCase() == 'paid';

  return SizedBox(
    height: 155,
    width: 354,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          16,
        ), // Use borderRadius for rounded corners
        border: Border.all(
          width: 1,
          color: theme.colorScheme.surface,
        ), // Use border for the border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(invoice.clientName, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoice.invoiceNumber,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: ThemeConfig.darkButtonTextDisabled,
                ),
              ),
              Text(
                '₹ ${invoice.amount.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(invoice.dueDate),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: ThemeConfig.darkButtonTextDisabled,
                ),
              ),
              Text(
                invoice.status,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _getStatusColor(invoice.status),
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
                onPressed: moreDotClicked,
                icon: const Icon(Icons.more_vert),
                color: theme.colorScheme.onBackground,
              ),
            ],
          ),
        ],
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

Widget buildFilterChip(
  ThemeData theme, {
  required String label,
  required bool isSelected,
  required VoidCallback onPressed,
}) {
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

class InvoiceSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InvoiceSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      style: TextStyle(color: theme.colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: 'Search Invoices',
        hintStyle: TextStyle(
          fontStyle: theme.textTheme.bodySmall?.fontStyle,
          color: ThemeConfig.darkButtonTextDisabled,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: ThemeConfig.darkButtonTextDisabled,
        ),
        fillColor: theme.colorScheme.surface,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
