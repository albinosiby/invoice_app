import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Invoices/screen/add_invoice_screen.dart';
import 'package:invoice_app/modules/Invoices/widget/invoice_widgets.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';
import 'package:invoice_app/widgets/widgets.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _sampleInvoices = [
    {
      'clientName': 'John Doe',
      'invoiceNumber': 'INV-001',
      'amount': 100.00,
      'dueDate': DateTime(2024, 6, 15),
      'status': 'Pending',
    },
    {
      'clientName': 'Jane Smith',
      'invoiceNumber': 'INV-002',
      'amount': 250.50,
      'dueDate': DateTime(2024, 6, 10),
      'status': 'Paid',
    },
    {
      'clientName': 'Mike Johnson',
      'invoiceNumber': 'INV-003',
      'amount': 75.25,
      'dueDate': DateTime(2024, 5, 30),
      'status': 'Overdue',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _handleFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _handleRecordPayment(int index) {
    setState(() {
      _sampleInvoices[index]['status'] = 'Paid';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Invoices',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
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
      body: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Search and Filter UI
            Row(
              children: [
                Expanded(
                  child: InvoiceSearchField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.surface,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      theme.brightness == Brightness.dark
                          ? Iconconstants.filterWhite
                          : Iconconstants.filterBlack,
                      height: 24,
                      width: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilterChip(
                  'All',
                  _selectedFilter == 'All',
                  () => _handleFilter('All'),
                  context,
                ),
                buildFilterChip(
                  'Pending',
                  _selectedFilter == 'Pending',
                  () => _handleFilter('Pending'),
                  context,
                ),
                buildFilterChip(
                  'Paid',
                  _selectedFilter == 'Paid',
                  () => _handleFilter('Paid'),
                  context,
                ),
                buildFilterChip(
                  'Overdue',
                  _selectedFilter == 'Overdue',
                  () => _handleFilter('Overdue'),
                  context,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Invoice List
            Expanded(child: _buildInvoiceList(theme)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddInvoiceScreen()));
        },
        label: Text(
          'Create Invoice',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeConfig.buttonTextPrimary,
          ),
        ),
        icon: Image.asset(Iconconstants.addInvoiceWhite, height: 24, width: 24),
        backgroundColor: theme.colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildInvoiceList(ThemeData theme) {
    final filteredInvoices = _sampleInvoices.where((invoice) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          invoice['clientName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          invoice['invoiceNumber'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesFilter =
          _selectedFilter == 'All' ||
          invoice['status'].toString().toLowerCase() ==
              _selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredInvoices.isEmpty) {
      return Center(
        child: Text(
          _searchQuery.isNotEmpty
              ? 'No invoices found for "$_searchQuery"'
              : 'No invoices found',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredInvoices.length,
      itemBuilder: (context, index) {
        final invoice = filteredInvoices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: buildInvoiceCard(
            theme,
            invoice['clientName'],
            invoice['invoiceNumber'],
            invoice['amount'],
            invoice['dueDate'],
            invoice['status'],
            () => _handleRecordPayment(
              _sampleInvoices.indexWhere(
                (inv) => inv['invoiceNumber'] == invoice['invoiceNumber'],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InvoiceSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InvoiceSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: controller,
        style: TextStyle(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Search Invoices',
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
        onChanged: onChanged,
      ),
    );
  }
}
