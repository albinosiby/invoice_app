import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/modules/Clients/screen/add_client.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  // State variables for the switches
  bool _markAsPaid = false;
  bool _acceptCardPayments = false;
  bool _requestSignature = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Using a dark theme as a base
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Invoice',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'INV00001',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.edit,
                  color: theme.colorScheme.onBackground,
                  size: 24,
                ),
              ],
            ),
            Text(
              'June 12, 2024',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),

            // Client Section
            Text(
              'Client',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 352,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddClientScreen(),
                    ),
                  );
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_1, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Add Client',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Items',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item 1',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      '1*₹100.00',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: ThemeConfig.darkSecondaryText,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹100.00',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: 356,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    'Subtotal',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹100.00',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Pricing Summary
            Text(
              'Pricing Summary',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Discount',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ThemeConfig.darkPrimaryAccent,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹0.00',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'GST(18%)',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ThemeConfig.darkPrimaryAccent,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹18.00',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹118.00',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Payments
            Text(
              'Payments',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add Payments',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ThemeConfig.darkPrimaryAccent,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹0.00',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Balance Due',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    '₹118.00',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mark as paid',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  Switch(
                    activeColor: ThemeConfig.buttonTextPrimary,
                    activeTrackColor: ThemeConfig.lightButtonTextDisabled,
                    inactiveThumbColor: ThemeConfig.buttonTextPrimary,
                    inactiveTrackColor: ThemeConfig.lightButtonTextDisabled,
                    trackOutlineColor: MaterialStateProperty.all(
                      ThemeConfig.lightButtonTextDisabled,
                    ),
                    value: _markAsPaid,
                    onChanged: (value) => setState(() => _markAsPaid = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment Options
            Text(
              'Payment Options',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: theme.colorScheme.onBackground,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Card Payments',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: ThemeConfig.buttonTextPrimary,
                    activeTrackColor: ThemeConfig.lightButtonTextDisabled,
                    inactiveThumbColor: ThemeConfig.buttonTextPrimary,
                    inactiveTrackColor: ThemeConfig.lightButtonTextDisabled,
                    trackOutlineColor: MaterialStateProperty.all(
                      ThemeConfig.lightButtonTextDisabled,
                    ),
                    value: _acceptCardPayments,
                    onChanged: (value) =>
                        setState(() => _acceptCardPayments = value),
                  ),
                ],
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.account_balance,
                color: theme.colorScheme.onBackground,
              ),
              title: Text(
                'Bank Account & Payment Info',
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onBackground,
              ),
              onTap: () {},
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.receipt_long,
                color: theme.colorScheme.onBackground,
              ),
              title: Text(
                'Deposit Request',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onBackground,
              ),
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // Attachments
            Text(
              'Attachments',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.image, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),

                  Text(
                    'Add Image',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ThemeConfig.darkPrimaryAccent,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add PDF',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ThemeConfig.darkPrimaryAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Client Acceptance
            Text(
              'Client Acceptance',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.draw,
                    color: theme.colorScheme.onBackground,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Request Sign & Acceptance',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: ThemeConfig.buttonTextPrimary,
                    activeTrackColor: ThemeConfig.lightButtonTextDisabled,
                    inactiveThumbColor: ThemeConfig.buttonTextPrimary,
                    inactiveTrackColor: ThemeConfig.lightButtonTextDisabled,
                    trackOutlineColor: MaterialStateProperty.all(
                      ThemeConfig.lightButtonTextDisabled,
                    ),
                    value: _requestSignature,
                    onChanged: (value) =>
                        setState(() => _requestSignature = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Notes
            Text(
              'Notes',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            TextField(
              maxLines: 5,
              style: TextStyle(color: theme.colorScheme.onBackground),
              decoration: InputDecoration(
                hintText: 'Notes',
                hintStyle: TextStyle(color: ThemeConfig.darkPlaceholderText),
                border: OutlineInputBorder(),
                fillColor: ThemeConfig.darkSurfaceOrCard,
              ),
            ),
            // Extra space to scroll past bottom bar
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 169,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.lightButtonTextDisabled,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Preview',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ThemeConfig.darkBackground,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 169,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ThemeConfig.lightBackground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
