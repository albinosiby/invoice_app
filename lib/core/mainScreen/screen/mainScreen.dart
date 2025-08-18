import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/config/themes/theme_config.dart';
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
    const InvoiceScreen(),
    const Clientscreen(),
    const EstimateScreen(),
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
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 24),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long, size: 24),
                    label: 'Invoices',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.description, size: 24),
                    label: 'Estimates',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people, size: 24),
                    label: 'Clients',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart, size: 24),
                    label: 'Reports',
                  ),
                ],
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
