import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/config/themes/theme_config.dart';
import 'package:invoice_app/constants/app_constants.dart';
import '../bloc/main_screen_bloc.dart';
import '../../../../../modules/home/screen/home_Screen.dart';
import '../../../../../modules/Clients/screen/client_screen.dart';
import '../../../../../modules/Estimates/screen/estimate_screen.dart';
import '../../../../../modules/Invoices/screen/invoice_screen.dart';
import '../../../../../modules/Reports/screen/report_screen.dart';

class Mainscreen extends StatelessWidget {
  final ThemeMode themeMode = ThemeMode.system;
  Mainscreen({super.key, currentThemeMode, toggleTheme, toggleSystemTheme});

  static final List<Widget> _screens = [
    const HomeScreen(),
    InvoicesScreen(),
    const EstimateScreen(),
    const ClientScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => MainScreenBloc(),
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is MainScreenTabState) {
            currentIndex = state.tabIndex;
          }
          return Scaffold(
            body: _screens[currentIndex],
            bottomNavigationBar: SizedBox(
              width: 400,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  int newIndex = currentIndex;
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! < 0 &&
                        currentIndex < _screens.length - 1) {
                      newIndex = currentIndex + 1;
                    } else if (details.primaryVelocity! > 0 &&
                        currentIndex > 0) {
                      newIndex = currentIndex - 1;
                    }
                    if (newIndex != currentIndex) {
                      context.read<MainScreenBloc>().add(
                        MainScreenTabChanged(newIndex),
                      );
                    }
                  }
                },
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  selectedItemColor: ThemeConfig.navIconActive,
                  unselectedItemColor: ThemeConfig.navIconInactive,
                  selectedLabelStyle: theme.textTheme.labelMedium,
                  unselectedLabelStyle: theme.textTheme.labelMedium,
                  onTap: (index) {
                    context.read<MainScreenBloc>().add(
                      MainScreenTabChanged(index),
                    );
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        currentIndex == 0
                            ? Iconconstants.navHomeSelected
                            : Iconconstants.navHome,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        currentIndex == 1
                            ? Iconconstants.navInvoiceSelected
                            : Iconconstants.navInvoice,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Invoices',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        currentIndex == 2
                            ? Iconconstants.navEstimateSelected
                            : Iconconstants.navEstimate,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Estimates',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        currentIndex == 3
                            ? Iconconstants.navClientSelected
                            : Iconconstants.navClient,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Clients',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        currentIndex == 4
                            ? Iconconstants.navReportSelected
                            : Iconconstants.navReport,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Reports',
                    ),
                  ],
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
