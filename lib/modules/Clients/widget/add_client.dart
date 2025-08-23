// lib/widgets/widgets.dart
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

Widget buildDropdownInput(
  BuildContext context,
  String? value,
  String hintText,
  List<String> items,
  Function(String?) onChanged,
) {
  return SizedBox(
    width: 354,
    height: 56,
    child: DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
