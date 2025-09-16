import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

// Widget: Items Section
Widget buildItemsSection(ThemeData theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Items',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      const SizedBox(height: 16),
      buildItemRow('Item 1', '1*₹100.00', '₹100.00', theme),
      const SizedBox(height: 16),
      SizedBox(
        width: 356,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Add Item',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
      buildPriceRow('Subtotal', '₹100.00', theme, isTotal: false),
    ],
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required TextInputType keyboardType,
  String? Function(String?)? validator,
  int maxLines = 1,
  required BuildContext context,
}) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: theme.textTheme.bodyLarge),
      const SizedBox(height: 6),
      SizedBox(
        width: 354,
        height: maxLines > 1 ? 150 : 56,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: theme.hintColor),
            filled: true,
            fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
        ),
      ),
    ],
  );
}

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

// Widget: Pricing Row with Icon
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

// Widget: Switch Option
Widget buildSwitchOption(
  name,
  String title,
  bool value,
  Function(bool) onChanged,
  ThemeData theme,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Image.asset(
          name,
          color: theme.colorScheme.onSurface,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        Switch(
          activeColor: ThemeConfig.buttonTextPrimary,
          activeTrackColor: ThemeConfig.lightButtonTextDisabled,
          inactiveThumbColor: ThemeConfig.buttonTextPrimary,
          inactiveTrackColor: ThemeConfig.lightButtonTextDisabled,
          trackOutlineColor: WidgetStateProperty.all(
            ThemeConfig.lightButtonTextDisabled,
          ),
          value: value,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}

// Widget: List Tile Option
Widget buildListTileOption(IconData icon, String title, ThemeData theme) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: theme.colorScheme.onSurface),
    title: Text(
      title,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    ),
    trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface),
    onTap: () {},
  );
}

// Widget: Attachment Option
Widget buildAttachmentOption(IconData icon, String label, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: ThemeConfig.darkPrimaryAccent,
          ),
        ),
      ],
    ),
  );
}

// Widget: Notes Section
Widget buildNotesSection(ThemeData theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Notes',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      TextField(
        maxLines: 5,
        style: TextStyle(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Notes',
          hintStyle: TextStyle(color: ThemeConfig.darkPlaceholderText),
          border: const OutlineInputBorder(),
          fillColor: ThemeConfig.darkSurfaceOrCard,
        ),
      ),
    ],
  );
}

// Widget: Action Buttons
Widget buildActionButtons(BuildContext context) {
  final theme = Theme.of(context);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildActionButton(
        'Preview',
        ThemeConfig.lightButtonTextDisabled,
        ThemeConfig.darkBackground,
        () {},
        169,
        context,
      ),
      buildActionButton(
        'Save',
        theme.colorScheme.primary,
        ThemeConfig.lightBackground,
        Navigator.of(context).pop,
        169,
        context,
      ),
    ],
  );
}

// Widget: Individual Action Button
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
