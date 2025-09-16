// file: lib/modules/home/screen/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/modules/Estimates/screen/add_estimate.dart';
import 'package:invoice_app/modules/Invoices/screen/add_invoice_screen.dart';
import 'package:invoice_app/modules/home/model/dashboard_model.dart';
import 'package:invoice_app/modules/home/repository/home_repository.dart';
import 'package:invoice_app/modules/home/widget/home_widgets.dart';
import 'package:invoice_app/modules/settings/screen/settings.dart';
import 'package:invoice_app/widgets/widgets.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(HomeRepository())..fetchHomeData(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    // The BlocConsumer is the root widget, allowing the entire Scaffold to rebuild based on state.
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        // Only rebuild the UI for states that display data.
        return current is HomeLoading ||
            current is HomeLoaded ||
            current is HomeError;
      },
      listener: (context, state) {
        // Handles one-time actions like navigation and showing SnackBars.
        if (state is NavigateToSettings) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => SettingsPage()));
        } else if (state is NavigateToCreateInvoice) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddInvoiceScreen()));
        } else if (state is NavigateToAddEstimate) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddEstimateScreen()));
        } else if (state is ReminderSentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reminder sent for ${state.invoiceNumber}!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PaymentRecordedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment recorded for ${state.invoiceNumber}!'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: _buildAppBarTitle(context, state), // Dynamic title
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? Iconconstants.settingsWhite
                      : Iconconstants.settingsBlack,
                ),
                onPressed: () => context.read<HomeCubit>().goToSettings(),
              ),
            ],
          ),
          body: _buildBodyContent(context, state), // Dynamic body
        );
      },
    );
  }

  /// Builds the AppBar title based on the current state.
  Widget _buildAppBarTitle(BuildContext context, HomeState state) {
    // Checks if data is loaded and a logo URL is available.
    if (state is HomeLoaded &&
        state.dashboardCards.isNotEmpty &&
        state.dashboardCards[0].logoImageUrl != null &&
        state.dashboardCards[0].logoImageUrl!.isNotEmpty) {
      final logoUrl = state.dashboardCards[0].logoImageUrl!;

      return CachedNetworkImage(
        imageUrl: logoUrl,
        height: 32, // Constrains the logo size
        // This builder is shown while the image is downloading.
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2.0),
            ),

        // This widget is shown if the image fails to load.
        errorWidget: (context, url, error) => const Text(
          'Logo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }

    // Default text title.
    return const Text(
      'Logo',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  /// Builds the body of the Scaffold based on the current state.
  Widget _buildBodyContent(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is HomeError) {
      return _ErrorState(message: state.message);
    }
    if (state is HomeLoaded) {
      return RefreshIndicator(
        onRefresh: () async => context.read<HomeCubit>().fetchHomeData(),
        child: _HomeLoadedContent(state: state),
      );
    }
    return const SizedBox.shrink(); // Initial state
  }
}

/// Widget to display the main content when data has been successfully loaded.
class _HomeLoadedContent extends StatelessWidget {
  final HomeLoaded state;
  const _HomeLoadedContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DashboardCardModel dashcardModel = state.dashboardCards[0];

    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              dashboardCard(
                theme,
                Icons.receipt_long,
                'Total Invoices',
                "₹ ${dashcardModel.totalInvoice}",
                '${dashcardModel.numberOfInvoice} invoices this month',
                const Color.fromRGBO(37, 99, 235, 0.1),
                ThemeConfig.darkPrimaryAccent,
              ),
              dashboardCard(
                theme,
                Icons.payment,
                'Payments Received',
                "₹ ${dashcardModel.paymentReceived}",
                '${dashcardModel.paymentrecivedPercent}% from last month',
                const Color.fromRGBO(52, 211, 153, 0.1),
                ThemeConfig.success,
              ),
              dashboardCard(
                theme,
                Icons.warning,
                'Outstanding Payments',
                "₹ ${dashcardModel.outstandingPayment}",
                '${dashcardModel.numberOfOverDue} clients overdue',
                const Color.fromRGBO(251, 191, 36, 0.1),
                ThemeConfig.warning,
              ),
              dashboardCard(
                theme,
                Icons.attach_money_sharp,
                'Expenses',
                "₹ ${dashcardModel.expense}",
                'Marketing & Supplies',
                const Color.fromRGBO(248, 113, 113, 0.1),
                ThemeConfig.error,
              ),
              dashboardCard(
                theme,
                Icons.trending_up,
                'Net Profit',
                "₹ ${dashcardModel.netProfit}",
                'After tax & deductions',
                const Color.fromRGBO(167, 139, 250, 0.1),
                ThemeConfig.info,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Upcoming Due Invoices', style: theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          if (state.dueInvoices.isNotEmpty)
            SizedBox(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.dueInvoices.length,
                itemBuilder: (context, index) {
                  final invoiceDueModel = state.dueInvoices[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index != state.dueInvoices.length - 1 ? 16 : 0,
                    ),
                    child: upComingDue(
                      theme,
                      invoiceDueModel.clientName,
                      invoiceDueModel.invoiceNumber,
                      invoiceDueModel.amount,
                      invoiceDueModel.status,
                      invoiceDueModel.daysDue,
                      invoiceDueModel.dueDate,
                      () => context.read<HomeCubit>().recordPaymentManually(
                        invoiceDueModel,
                      ),
                      () => context.read<HomeCubit>().sendReminder(
                        invoiceDueModel,
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Center(child: Text('No upcoming due invoices.')),
            ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallButtton(
                context,
                'Create Invoice',
                () => context.read<HomeCubit>().goToCreateInvoice(),
                Iconconstants.addInvoiceWhite,
              ),
              smallButtton(
                context,
                'Add Estimate',
                () => context.read<HomeCubit>().goToAddEstimate(),
                Iconconstants.plusBoxWhite,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Widget to display an error message and a retry button.
class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<HomeCubit>().fetchHomeData(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
