import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Clients/screen/add_client.dart';
import 'package:invoice_app/modules/Invoices/widget/add_invoice_widgets.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  bool _markAsPaid = false;
  bool _acceptCardPayments = false;
  bool _requestSignature = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Invoice',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              theme.brightness == Brightness.dark
                  ? Iconconstants.settingsWhite
                  : Iconconstants.settingsBlack,
              height: 24,
              width: 24,
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

            // Header Section
            _buildHeaderSection(theme),
            const SizedBox(height: 16),

            // Client Section
            _buildClientSection(theme),
            const SizedBox(height: 16),

            // Items Section
            _buildItemsSection(theme),
            const SizedBox(height: 16),

            // Pricing Summary
            _buildPricingSummary(theme),
            const SizedBox(height: 16),

            // Payments Section
            _buildPaymentsSection(theme),
            const SizedBox(height: 16),

            // Payment Options
            _buildPaymentOptions(theme),
            const SizedBox(height: 16),

            // Attachments
            _buildAttachmentsSection(theme),
            const SizedBox(height: 16),

            // Client Acceptance
            _buildClientAcceptance(theme),
            const SizedBox(height: 10),

            // Notes
            _buildNotesSection(theme),
            const SizedBox(height: 20),

            // Action Buttons
            buildActionButtons(context),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Widget: Header Section
  Widget _buildHeaderSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'INV00001',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.edit, color: theme.colorScheme.onBackground, size: 24),
          ],
        ),
        Text(
          'June 12, 2024',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  // Widget: Client Section
  Widget _buildClientSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => AddClientScreen())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_alt_1, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Add Client',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget: Items Section
  Widget _buildItemsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
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

  Widget _buildPricingSummary(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing Summary',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 10),
        buildPricingRow(Iconconstants.plusBoxWhite, 'Discount', '₹0.00', theme),
        buildPricingRow(
          Iconconstants.plusBoxWhite,
          'GST(18%)',
          '₹18.00',
          theme,
        ),
        buildPriceRow('Total', '₹118.00', theme, isTotal: true),
      ],
    );
  }

  // Widget: Pricing Row with Icon
  Widget _buildPaymentsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payments',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        buildPricingRow(
          Iconconstants.plusBoxWhite,
          'Add Payments',
          '₹0.00',
          theme,
        ),
        buildPriceRow('Balance Due', '₹118.00', theme, isTotal: true),
        _buildSwitchOption(
          theme.brightness == Brightness.dark
              ? Iconconstants.cardBlack
              : Iconconstants.cardWhite,
          'Mark as paid',
          _markAsPaid,
          (value) => setState(() => _markAsPaid = value),
          theme,
        ),
      ],
    );
  }

  // Widget: Payment Options
  Widget _buildPaymentOptions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Options',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        _buildSwitchOption(
          theme.brightness == Brightness.dark
              ? Iconconstants.cardWhite
              : Iconconstants.cardBlack,
          'Card Payments',
          _acceptCardPayments,
          (value) => setState(() => _acceptCardPayments = value),
          theme,
        ),
        _buildListTileOption(
          Icons.account_balance,
          'Bank Account & Payment Info',
          theme,
        ),
        _buildListTileOption(Icons.receipt_long, 'Deposit Request', theme),
      ],
    );
  }

  // Widget: Switch Option
  Widget _buildSwitchOption(
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
          Image.asset(name, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            title,
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
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Widget: List Tile Option
  Widget _buildListTileOption(IconData icon, String title, ThemeData theme) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: theme.colorScheme.onBackground),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onBackground,
      ),
      onTap: () {},
    );
  }

  // Widget: Attachments Section
  Widget _buildAttachmentsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        _buildAttachmentOption(Icons.image, 'Add Image', theme),
        _buildAttachmentOption(Icons.picture_as_pdf, 'Add PDF', theme),
      ],
    );
  }

  // Widget: Attachment Option
  Widget _buildAttachmentOption(IconData icon, String label, ThemeData theme) {
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

  // Widget: Client Acceptance
  Widget _buildClientAcceptance(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Client Acceptance',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        _buildSwitchOption(
          theme.brightness == Brightness.dark
              ? Iconconstants.signWhite
              : Iconconstants.signBlack,
          'Request Sign & Acceptance',
          _requestSignature,
          (value) => setState(() => _requestSignature = value),
          theme,
        ),
      ],
    );
  }

  // Widget: Notes Section
  Widget _buildNotesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            border: const OutlineInputBorder(),
            fillColor: ThemeConfig.darkSurfaceOrCard,
          ),
        ),
      ],
    );
  }

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
}
