import 'package:flutter/material.dart';

Widget customButtonLarge(
  BuildContext context,
  String text,
  VoidCallback onPressed,
) {
  return SizedBox(
    width: 354,
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
    ),
  );
}

Widget buildSectionHeader(String title, context) {
  final theme = Theme.of(context);

  return Text(
    title,
    style: theme.textTheme.headlineSmall?.copyWith(
      color: theme.colorScheme.onSurface,
    ),
  );
}

// Widget: Text Field
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

// Widget: Dropdown Field
Widget buildDropdownField({
  required String? value,
  required String label,
  required String hint,
  required List<String> items,
  required Function(String?) onChanged,
  required BuildContext context,
}) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: theme.textTheme.bodyLarge),
      const SizedBox(height: 6),
      Container(
        width: 354,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint, style: TextStyle(color: theme.hintColor)),
            isExpanded: true,
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

// Widget: Notes Field
Widget buildNotesField(notesController, context) {
  return buildTextField(
    controller: notesController,
    label: 'Notes',
    hint: 'Add notes',
    keyboardType: TextInputType.multiline,
    maxLines: 8,
    context: context,
  );
}
