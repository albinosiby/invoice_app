import 'package:flutter/material.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Clients/screen/add_client.dart';
import 'package:invoice_app/modules/Estimates/widget/add_estimate_widget.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class AddEstimateScreen extends StatefulWidget {
  const AddEstimateScreen({super.key});

  @override
  State<AddEstimateScreen> createState() => _AddEstimateScreenState();
}

class _AddEstimateScreenState extends State<AddEstimateScreen> {
  bool _acceptCardPayments = false;
  bool _requestSignature = false;
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
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
            buildHeaderSection(theme),
            const SizedBox(height: 16),

            // Client Section
            buildClientSection(theme),
            const SizedBox(height: 16),

            // Items Section
            buildItemsSection(theme),
            const SizedBox(height: 16),

            // Pricing Summary
            buildPricingSummary(theme),
            const SizedBox(height: 16),

            // Payment Options
            buildPaymentOptions(theme),
            const SizedBox(height: 16),

            // Attachments
            buildAttachmentsSection(theme),
            const SizedBox(height: 16),

            // Client Acceptance
            buildClientAcceptance(theme),
            const SizedBox(height: 10),

            // Notes
            buildTextField(
              controller: notesController,
              label: 'Notes',
              hint: 'Add notes',
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              context: context,
            ),
            const SizedBox(height: 20),

            // Action Buttons
            buildActionButtons(context),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderSection(ThemeData theme) {
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
  Widget buildClientSection(ThemeData theme) {
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

  // Widget: Pricing Summary
  Widget buildPricingSummary(ThemeData theme) {
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

  Widget buildPaymentOptions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Options',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        buildSwitchOption(
          theme.brightness == Brightness.dark
              ? Iconconstants.cardWhite
              : Iconconstants.cardBlack,
          'Card Payments',
          _acceptCardPayments,
          (value) => setState(() => _acceptCardPayments = value),
          theme,
        ),
        buildListTileOption(
          Icons.account_balance,
          'Bank Account & Payment Info',
          theme,
        ),
        buildListTileOption(Icons.receipt_long, 'Deposit Request', theme),
      ],
    );
  }

  // Widget: Attachments Section
  Widget buildAttachmentsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        buildAttachmentOption(Icons.image, 'Add Image', theme),
        buildAttachmentOption(Icons.picture_as_pdf, 'Add PDF', theme),
      ],
    );
  }

  Widget buildClientAcceptance(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Client Acceptance',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        buildSwitchOption(
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
}
