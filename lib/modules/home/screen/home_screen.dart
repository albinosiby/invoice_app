import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/modules/home/widget/home_widgets.dart';
import 'package:invoice/config/themes/theme_config.dart';
import 'package:invoice/modules/settings/screen/settings.dart';
import '../bloc/home_bloc.dart';
import '../repository/home_repository.dart';
import '../model/dashboard_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(HomeRepository())..add(LoadHomeData()),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      //backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Logo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: theme.colorScheme.onBackground),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: theme.colorScheme.onBackground),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeLoaded) {
            final DashboardCardModel dashcardModel = state.dashboardCards[0];
            //final InvoiceDueModel invoiceDueModel = state.dueInvoices[0];
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 11,
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
                  Text(
                    'Upcoming Due Invoices',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  if (state.dueInvoices.isNotEmpty)
                    SizedBox(
                      height: 160,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: state.dueInvoices.length,
                        itemBuilder: (context, index) {
                          final invoiceDueModel = state.dueInvoices[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index != state.dueInvoices.length - 1
                                  ? 16
                                  : 0,
                            ),
                            child: upComingDue(
                              theme,
                              invoiceDueModel.clientName,
                              invoiceDueModel.invoiceNumber,
                              invoiceDueModel.amount,
                              invoiceDueModel.status,
                              invoiceDueModel.daysDue,
                              invoiceDueModel.dueDate,
                            ),
                          );
                        },
                      ),
                    )
                  else
                    const Center(child: Text('No popular workouts available')),
                  // upComingDue(
                  //   theme,
                  //   invoiceDueModel.clientName,
                  //   invoiceDueModel.invoiceNumber,
                  //   invoiceDueModel.amount,
                  //   invoiceDueModel.status,
                  //   invoiceDueModel.daysDue,
                  //   invoiceDueModel.dueDate,
                  // ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: smallButtton(context, 'Create Invoice', () {}),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: smallButtton(context, 'Add Estimate', () {}),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
