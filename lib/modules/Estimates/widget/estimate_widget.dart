import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

Widget buildSwipeBackground(bool isAccept) {
  return Container(
    decoration: BoxDecoration(
      color: isAccept ? Colors.green : Colors.red,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Align(
      alignment: isAccept ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          isAccept ? 'ACCEPT' : 'DECLINE',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buildEstimateCard(
  ThemeData theme,
  String clientName,
  String estimateNumber,
  double amount,
  DateTime dueDate,
  String status,
  VoidCallback? onConvertToInvoice,
) {
  final bool isAccepted = status.toLowerCase() == 'accepted';
  final bool isCancelled = status.toLowerCase() == 'cancelled';

  return SizedBox(
    height: 155,
    width: 356,
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: theme.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
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
                  estimateNumber,
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
                  onPressed: isAccepted || isCancelled
                      ? null
                      : onConvertToInvoice,
                  child: Text(
                    isAccepted ? 'Converted to Invoice' : 'Convert to Invoice',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isAccepted || isCancelled
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

Widget buildSearchField(ThemeData theme, searchController, handleSearch) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(12),
    child: TextField(
      controller: searchController,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: 'Search Estimates',
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
      onChanged: handleSearch,
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
    case 'accepted':
      return ThemeConfig.success;
    case 'pending':
      return ThemeConfig.warning;
    case 'cancelled':
      return ThemeConfig.error;
    default:
      return ThemeConfig.darkButtonTextDisabled;
  }
}
