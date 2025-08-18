import 'package:flutter/material.dart';
import 'package:invoice/modules/settings/widget/settings_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
            buildListTile(context, Icons.person_outline, 'Account Info'),
            buildListTile(context, Icons.star_border, 'Subscription'),
            buildListTile(context, Icons.calendar_today, 'Billing'),
            buildSectionHeader(context, 'Preferences'),
            buildListTile(context, Icons.settings_outlined, 'App Preferences'),
            buildListTile(context, Icons.notifications_none, 'Notifications'),
            buildListTile(context, Icons.mail_outline, 'Email Settings'),
            buildSectionHeader(context, 'Support'),
            buildListTile(context, Icons.help_outline, 'Help Center'),
            buildListTile(
              context,
              Icons.chat_bubble_outline,
              'Contact Support',
            ),
            buildListTile(context, Icons.campaign_outlined, 'Send Feedback'),
          ],
        ),
      ),
    );
  }
}
