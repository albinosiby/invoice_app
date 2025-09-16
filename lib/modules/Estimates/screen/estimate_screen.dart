import 'package:flutter/material.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Estimates/screen/add_estimate.dart';
import 'package:invoice_app/modules/Estimates/widget/estimate_widget.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';
import 'package:invoice_app/widgets/widgets.dart';

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({super.key});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _sampleEstimate = [
    {
      'id': '1',
      'clientName': 'John Doe',
      'EstimateNumber': 'EST-001',
      'amount': 100.00,
      'dueDate': DateTime(2024, 6, 15),
      'status': 'Pending',
    },
    {
      'id': '2',
      'clientName': 'Jane Smith',
      'EstimateNumber': 'EST-002',
      'amount': 250.50,
      'dueDate': DateTime(2024, 6, 10),
      'status': 'Accepted',
    },
    {
      'id': '3',
      'clientName': 'Mike Johnson',
      'EstimateNumber': 'EST-003',
      'amount': 75.25,
      'dueDate': DateTime(2024, 5, 30),
      'status': 'Cancelled',
    },
    {
      'id': '4',
      'clientName': 'Johnson',
      'EstimateNumber': 'EST-004',
      'amount': 65.25,
      'dueDate': DateTime(2024, 5, 29),
      'status': 'Pending',
    },
    {
      'id': '5',
      'clientName': 'Smith',
      'EstimateNumber': 'EST-006',
      'amount': 250.50,
      'dueDate': DateTime(2024, 4, 13),
      'status': 'Accepted',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _handleFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void handleAcceptEstimate(int index) {
    setState(() {
      _sampleEstimate[index]['status'] = 'Accepted';
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Estimate accepted')));
  }

  void handleDeclineEstimate(int index) {
    setState(() {
      _sampleEstimate[index]['status'] = 'Cancelled';
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Estimate declined')));
  }

  void handleConvertToInvoice(int index) {
    setState(() {
      _sampleEstimate[index]['status'] = 'Accepted';
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Converted to invoice')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Estimates',
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
                  child: buildSearchField(
                    theme,
                    _searchController,
                    handleSearch,
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
                  'Accepted',
                  _selectedFilter == 'Accepted',
                  () => _handleFilter('Accepted'),
                  context,
                ),
                buildFilterChip(
                  'Pending',
                  _selectedFilter == 'Pending',
                  () => _handleFilter('Pending'),
                  context,
                ),
                buildFilterChip(
                  'Cancelled',
                  _selectedFilter == 'Cancelled',
                  () => _handleFilter('Cancelled'),
                  context,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Estimate List
            Expanded(child: _buildEstimateList(theme)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddEstimateScreen()));
        },
        label: Text(
          'Create Estimate',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeConfig.buttonTextPrimary,
          ),
        ),
        icon: Image.asset(Iconconstants.plusBoxWhite, height: 24, width: 24),
        backgroundColor: theme.colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildEstimateList(ThemeData theme) {
    final filteredEstimates = _sampleEstimate.where((estimate) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          estimate['clientName'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          estimate['EstimateNumber'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesFilter =
          _selectedFilter == 'All' ||
          estimate['status'].toString().toLowerCase() ==
              _selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredEstimates.isEmpty) {
      return Center(
        child: Text(
          _searchQuery.isNotEmpty
              ? 'No Estimate found for "$_searchQuery"'
              : 'No Estimate found',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredEstimates.length,
      itemBuilder: (context, index) {
        final estimate = filteredEstimates[index];
        final originalIndex = _sampleEstimate.indexWhere(
          (e) => e['id'] == estimate['id'],
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: buildDismissibleEstimateCard(
            theme,
            estimate['clientName'],
            estimate['EstimateNumber'],
            estimate['amount'],
            estimate['dueDate'],
            estimate['status'],
            originalIndex,
          ),
        );
      },
    );
  }

  Widget buildDismissibleEstimateCard(
    ThemeData theme,
    String clientName,
    String estimateNumber,
    double amount,
    DateTime dueDate,
    String status,
    int index,
  ) {
    // Only allow swiping for pending estimates
    final bool canSwipe = status.toLowerCase() == 'pending';

    return Dismissible(
      key: Key(estimateNumber),
      direction: canSwipe ? DismissDirection.horizontal : DismissDirection.none,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe right to accept
          handleAcceptEstimate(index);
          return false; // Don't dismiss, we'll handle it manually
        } else if (direction == DismissDirection.endToStart) {
          // Swipe left to decline
          handleDeclineEstimate(index);
          return false; // Don't dismiss, we'll handle it manually
        }
        return false;
      },
      background: buildSwipeBackground(true), // Green for accept (right swipe)
      secondaryBackground: buildSwipeBackground(
        false,
      ), // Red for decline (left swipe)
      child: buildEstimateCard(
        theme,
        clientName,
        estimateNumber,
        amount,
        dueDate,
        status,
        canSwipe ? () => handleConvertToInvoice(index) : null,
      ),
    );
  }
}
