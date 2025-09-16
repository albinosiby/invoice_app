import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/modules/Reports/widget/report_widget.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Invoices';
  String _searchQuery = '';
  String _selectedYear = "2025";
  String _selectedClient = "All Clients";
  String _selectedCategory = "All Categories";

  final List<String> _years = ["2023", "2024", "2025", "2026", "2027"];
  final List<String> _clients = [
    "All Clients",
    "Client A",
    "Client B",
    "Client C",
  ];
  final List<String> _categories = [
    "All Categories",
    "Category 1",
    "Category 2",
    "Category 3",
  ];

  // Chart-related state
  LineChartData chartData = LineChartData();
  List<FlSpot> flspots = [FlSpot(0, 0)];
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    setChartData();
    startCreatingDemoData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void startCreatingDemoData() async {
    for (int i = 0; i < 12; i++) {
      if (i == 0) continue;
      await Future.delayed((Duration(seconds: 1))).then((value) {
        Random random = Random();
        setState(() {
          flspots.add(
            FlSpot(double.parse(i.toString()), random.nextDouble() * 6),
          );
          setChartData();
        });
      });
    }
  }

  void setChartData() {
    chartData = LineChartData(
      gridData: FlGridData(
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        // show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, meta) => Text(
              meta.formattedValue,
              style: TextStyle(
                color: ThemeConfig.darkButtonTextDisabled,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              meta.formattedValue,
              style: TextStyle(
                color: ThemeConfig.darkButtonTextDisabled,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            reservedSize: 28,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: flspots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
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
          'Reports',
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Search Field
            _buildSearchField(theme),
            const SizedBox(height: 16),

            // Filter Chips
            _buildFilterChips(theme),
            const SizedBox(height: 24),

            // Dropdown Filters
            _buildDropdownFilters(theme),
            const SizedBox(height: 20),

            // Report Content based on selected filter
            _buildReportContent(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surface,
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: theme.colorScheme.onBackground),
        decoration: InputDecoration(
          hintText: 'Search Reports',
          hintStyle: TextStyle(color: ThemeConfig.darkButtonTextDisabled),
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
        onChanged: _handleSearch,
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 4),
          _buildFilterChip(
            'Invoices',
            _selectedFilter == 'Invoices',
            () => _handleFilter('Invoices'),
            theme,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Expenses',
            _selectedFilter == 'Expenses',
            () => _handleFilter('Expenses'),
            theme,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Balance',
            _selectedFilter == 'Balance',
            () => _handleFilter('Balance'),
            theme,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool isSelected,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(84, 38),
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 1, color: theme.colorScheme.surface),
        ),
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surface,
        foregroundColor: isSelected
            ? Colors.white
            : ThemeConfig.darkButtonTextDisabled,
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? Colors.white
                : ThemeConfig.darkButtonTextDisabled,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownFilters(ThemeData theme) {
    return Column(
      children: [
        buildDropdown(_selectedYear, _years, (value) {
          setState(() {
            _selectedYear = value!;
          });
        }, theme),
        const SizedBox(height: 12),
        buildDropdown(_selectedClient, _clients, (value) {
          setState(() {
            _selectedClient = value!;
          });
        }, theme),
        const SizedBox(height: 12),
        buildDropdown(_selectedCategory, _categories, (value) {
          setState(() {
            _selectedCategory = value!;
          });
        }, theme),
      ],
    );
  }

  Widget _buildReportContent(ThemeData theme) {
    switch (_selectedFilter) {
      case 'Invoices':
        return _buildInvoicesSection(theme);
      case 'Expenses':
        return _buildExpensesSection(theme);
      case 'Balance':
        return _buildBalanceSection(theme);
      default:
        return _buildInvoicesSection(theme);
    }
  }

  Widget _buildInvoicesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reportGraphSection(theme),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildReportCard(
              theme,
              'Total Invoices',
              '₹ 12,345',
              ThemeConfig.lightPrimaryAccent.withOpacity(0.3),
              169,
            ),
            const SizedBox(width: 12),
            buildReportCard(
              theme,
              'Paid Invoices',
              '₹ 7,890',
              ThemeConfig.success.withOpacity(0.3),
              169,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildReportCard(
              theme,
              'Pending Invoice',
              '₹ 4,455',
              ThemeConfig.warning.withOpacity(0.3),
              169,
            ),
            const SizedBox(width: 12),
            buildReportCard(
              theme,
              'Overdue Invoices',
              '₹ 9,000',
              Colors.pink.withOpacity(0.3),
              169,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpensesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reportGraphSection(theme),
        const SizedBox(height: 12),
        buildExpandedReportCard(
          theme,
          'Total Expenses',
          '₹ 12,345',
          ThemeConfig.lightPrimaryAccent.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildBalanceSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reportGraphSection(theme),
        const SizedBox(height: 12),
        buildExpandedReportCard(
          theme,
          'Balance',
          '₹ 12,345',
          ThemeConfig.lightPrimaryAccent.withOpacity(0.3),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildReportCard(
              theme,
              'Invoices',
              '₹ 4,455',
              ThemeConfig.warning.withOpacity(0.3),
              169,
            ),
            buildReportCard(
              theme,
              'Expenses',
              '₹ 9,000',
              Colors.pink.withOpacity(0.3),
              169,
            ),
          ],
        ),
      ],
    );
  }

  Widget reportGraphSection(ThemeData theme) {
    return SizedBox(
      height: 234,
      width: 345,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: LineChart(chartData),
        ),
      ),
    );
  }
}
