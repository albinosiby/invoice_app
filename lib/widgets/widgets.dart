import 'package:flutter/material.dart';

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
