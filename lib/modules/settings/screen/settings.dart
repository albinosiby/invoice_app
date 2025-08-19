// file: lib/modules/settings/screen/settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/core/auth/screen/login_screen.dart';
import 'package:invoice_app/modules/settings/cubit/settings_cubit.dart';

import 'package:invoice_app/modules/settings/widget/settings_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the new, simpler cubit
      create: (context) => SettingsCubit(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    // The BlocConsumer wraps the Scaffold
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        // The LISTENER handles all navigation based on the state
        if (state is NavigateToAccountInfo) {
          //Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AccountInfoPage()));
        } else if (state is NavigateToSubscription) {
          //Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionPage()));
        } else if (state is NavigateToBilling) {
          // You would navigate to a BillingPage here
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Navigate to Billing')));
        } else if (state is LoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        // The BUILDER simply returns the static UI. It doesn't need to check the state.
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionHeader(context, 'Account'),
                buildListTile(
                  context,
                  Icons.person_outline,
                  'Account Info',
                  () => context.read<SettingsCubit>().goToAccountInfo(),
                ),
                buildListTile(
                  context,
                  Icons.star_border,
                  'Subscription',
                  () => context.read<SettingsCubit>().goToSubscription(),
                ),
                buildListTile(
                  context,
                  Icons.calendar_today,
                  'Billing',
                  () => context.read<SettingsCubit>().goToBilling(),
                ),

                const SizedBox(height: 16),
                buildSectionHeader(context, 'Preferences'),

                // App Preferences tile remains the same, using the separate ThemeCubit logic
                buildListTile(
                  context,
                  Icons.settings_outlined,
                  'App Preferences',
                  () => showThemePreferenceDialog(context),
                ),

                buildListTile(
                  context,
                  Icons.notifications_none,
                  'Notifications',
                  () {},
                ),
                buildListTile(
                  context,
                  Icons.mail_outline,
                  'Email Settings',
                  () {},
                ),

                const SizedBox(height: 16),
                buildSectionHeader(context, 'Support'),

                buildListTile(
                  context,
                  Icons.help_outline,
                  'Help Center',
                  () {},
                ),
                buildListTile(
                  context,
                  Icons.chat_bubble_outline,
                  'Contact Support',
                  () {},
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
