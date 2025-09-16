// lib/modules/Clients/screen/client_screen.dart
import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Clients/screen/add_client.dart';
import 'package:invoice_app/modules/Clients/widget/client_widget.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';
import 'package:invoice_app/widgets/widgets.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _sampleClients = [
    {
      'id': '1',
      'fullName': 'John Doe',
      'companyName': 'ABC Company',
      'email': 'john@abc.com',
      'numberofInvoices': 5,
      'amountDue': 1500.00,
      'createdAt': DateTime(2024, 6, 15),
      'status': 'active', // Added status for filtering
    },
    {
      'id': '2',
      'fullName': 'Jane Smith',
      'companyName': 'XYZ Corp',
      'email': 'jane@xyz.com',
      'numberofInvoices': 3,
      'amountDue': 750.50,
      'createdAt': DateTime(2024, 6, 10),
      'status': 'active',
    },
    {
      'id': '3',
      'fullName': 'Mike Johnson',
      'companyName': 'Tech Solutions',
      'email': 'mike@tech.com',
      'numberofInvoices': 8,
      'amountDue': 320.75,
      'createdAt': DateTime(2024, 5, 30),
      'status': 'recurrent', // Recurrent client
    },
    {
      'id': '4',
      'fullName': 'Emily Davis',
      'companyName': 'Creative Agency',
      'email': 'emily@tech.com',
      'numberofInvoices': 2,
      'amountDue': 0.00,
      'createdAt': DateTime(2024, 5, 25),
      'status': 'inactive', // Inactive client
    },
  ];

  List<Map<String, dynamic>> _filterClients(
    List<Map<String, dynamic>> clients,
  ) {
    // Apply search filter first
    var filteredClients = clients.where((client) {
      return _searchQuery.isEmpty ||
          client['fullName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          client['companyName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          client['email'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();

    // Apply status filtering
    if (_selectedFilter == 'New') {
      filteredClients.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    } else if (_selectedFilter == 'Ongoing') {
      filteredClients = filteredClients
          .where((client) => client['status'] == 'active')
          .toList();
    } else if (_selectedFilter == 'Recurrent') {
      filteredClients = filteredClients
          .where((client) => client['status'] == 'recurrent')
          .toList();
    }
    // 'All' filter shows all clients without additional filtering

    return filteredClients;
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
                  child: ClientSearchField(
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  buildFilterChip(
                    'All',
                    _selectedFilter == 'All',
                    () => _handleFilter('All'),
                    context,
                  ),
                  const SizedBox(width: 8),
                  buildFilterChip(
                    'New',
                    _selectedFilter == 'New',
                    () => _handleFilter('New'),
                    context,
                  ),
                  const SizedBox(width: 8),
                  buildFilterChip(
                    'Ongoing',
                    _selectedFilter == 'Ongoing',
                    () => _handleFilter('Ongoing'),
                    context,
                  ),
                  const SizedBox(width: 8),
                  buildFilterChip(
                    'Recurrent',
                    _selectedFilter == 'Recurrent',
                    () => _handleFilter('Recurrent'),
                    context,
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Client List
            Expanded(child: _buildClientList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddClientScreen()));
        },
        label: Text(
          'Add Client', // Changed from 'Create Invoice' to 'Add Client'
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeConfig.buttonTextPrimary,
          ),
        ),
        icon: Image.asset(
          Iconconstants.addPersonWhite,
          height: 24,
          width: 24,
          color: ThemeConfig.buttonTextPrimary,
        ), // Changed icon to image
        backgroundColor: theme.colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildClientList() {
    final displayedClients = _filterClients(_sampleClients);

    if (displayedClients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No clients match your search'
                  : 'No clients found',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
                child: const Text('Clear search'),
              ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: displayedClients.length,
      itemBuilder: (context, index) {
        final client = displayedClients[index];
        return buildClientCard(client, context);
      },
    );
  }
}

class ClientSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ClientSearchField({
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
      color: theme.colorScheme.surface,
      child: TextField(
        controller: controller,
        style: TextStyle(color: theme.colorScheme.onBackground),
        decoration: InputDecoration(
          hintText: 'Search Clients', // Changed from 'Search Invoices'
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
