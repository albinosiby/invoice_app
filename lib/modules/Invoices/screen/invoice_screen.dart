import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/modules/Invoices/cubit/invoice_cubit.dart';
import 'package:invoice_app/modules/Invoices/model/invoice_model.dart';
import 'package:invoice_app/modules/Invoices/repository/invoice_repository.dart';
import 'package:invoice_app/modules/Invoices/screen/add_invoice_screen.dart';
import 'package:invoice_app/modules/Invoices/widget/invoice_widgets.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';
import 'package:invoice_app/config/themes/theme_config.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late InvoiceCubit _invoiceCubit;

  @override
  void initState() {
    super.initState();
    _invoiceCubit = InvoiceCubit(repository: MockInvoiceRepository());
    _invoiceCubit.loadInvoices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _invoiceCubit.close();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (query.isEmpty) {
      _invoiceCubit.loadInvoices();
    } else {
      _invoiceCubit.searchInvoices(query);
    }
  }

  void _handleFilter(String filter) {
    _invoiceCubit.filterInvoicesByStatus(filter);
  }

  void _handleRecordPayment(Invoice invoice) {
    // Update invoice status to paid
    final updatedInvoice = invoice.copyWith(status: 'Paid');
    _invoiceCubit.updateInvoice(updatedInvoice);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => _invoiceCubit,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Invoices',
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
                  BlocConsumer<InvoiceCubit, InvoiceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final selectedFilter = state is InvoiceLoaded
                          ? state.selectedFilter
                          : 'All';
                      return buildFilterChip(
                        theme,
                        label: 'All',
                        isSelected: selectedFilter == 'All',
                        onPressed: () => _handleFilter('All'),
                      );
                    },
                  ),
                  BlocConsumer<InvoiceCubit, InvoiceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final selectedFilter = state is InvoiceLoaded
                          ? state.selectedFilter
                          : 'All';
                      return buildFilterChip(
                        theme,
                        label: 'Pending',
                        isSelected: selectedFilter == 'Pending',
                        onPressed: () => _handleFilter('Pending'),
                      );
                    },
                  ),
                  BlocConsumer<InvoiceCubit, InvoiceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final selectedFilter = state is InvoiceLoaded
                          ? state.selectedFilter
                          : 'All';
                      return buildFilterChip(
                        theme,
                        label: 'Paid',
                        isSelected: selectedFilter == 'Paid',
                        onPressed: () => _handleFilter('Paid'),
                      );
                    },
                  ),
                  BlocConsumer<InvoiceCubit, InvoiceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final selectedFilter = state is InvoiceLoaded
                          ? state.selectedFilter
                          : 'All';
                      return buildFilterChip(
                        theme,
                        label: 'Overdue',
                        isSelected: selectedFilter == 'Overdue',
                        onPressed: () => _handleFilter('Overdue'),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Invoice List with BlocConsumer
              Expanded(
                child: BlocConsumer<InvoiceCubit, InvoiceState>(
                  listener: (context, state) {
                    if (state is InvoiceError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is InvoiceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InvoiceError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    } else if (state is InvoiceLoaded) {
                      final invoices = state.invoices;
                      if (invoices.isEmpty) {
                        return Center(
                          child: Text(
                            state.searchQuery.isNotEmpty
                                ? 'No invoices found for "${state.searchQuery}"'
                                : 'No invoices found',
                            style: theme.textTheme.bodyMedium,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: invoices.length,
                        itemBuilder: (context, index) {
                          final invoice = invoices[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 9.0),
                            child: invoiceCard(
                              theme,
                              invoice,
                              () => _handleRecordPayment(invoice),
                              () => () {},
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddInvoiceScreen()));
          },
          label: Text(
            'Create Invoice',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ThemeConfig.buttonTextPrimary,
            ),
          ),
          icon: const Icon(
            Icons.add_chart,
            color: ThemeConfig.buttonTextPrimary,
          ),
          backgroundColor: theme.colorScheme.primary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
