import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/modules/Invoices/widget/invoice_widgets.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class Clientscreen extends StatelessWidget {
  const Clientscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // Hardcoded background color
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Clients',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => SettingsPage())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Search and Filter UI
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search Estimate',
                      hintStyle: const TextStyle(
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
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                    color: ThemeConfig.darkButtonTextDisabled,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // buildFilterChip(theme, label: 'All', isSelected: true),
                // buildFilterChip(theme, label: 'New', isSelected: false),
                // buildFilterChip(theme, label: 'Ongoing', isSelected: false),
                // buildFilterChip(theme, label: 'Recurrent', isSelected: false),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Add Client',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeConfig.buttonTextPrimary,
          ),
        ),
        icon: const Icon(
          Icons.person_add,
          color: ThemeConfig.buttonTextPrimary,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
