import 'package:flutter/material.dart';

Widget buildDropdown(
  String value,
  List<String> items,
  ValueChanged<String?> onChanged,
  ThemeData theme,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: theme.colorScheme.onSurface.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: DropdownButton<String>(
      value: value,
      isExpanded: true,
      icon: Icon(
        Icons.unfold_more,
        color: theme.colorScheme.onSurface.withOpacity(0.6),
      ),
      underline: const SizedBox(),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: theme.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

Widget buildReportCard(
  ThemeData theme,
  String title,
  String value,
  Color color,
  double width,
) {
  return SizedBox(
    height: 85,
    width: width,
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.colorScheme.onSurface,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildExpandedReportCard(
  ThemeData theme,
  String title,
  String value,
  Color color,
) {
  return SizedBox(
    height: 85,
    width: double.infinity,
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.colorScheme.onSurface,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
