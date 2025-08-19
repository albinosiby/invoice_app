import 'package:flutter/material.dart';

import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/core/mainScreen/screen/mainScreen.dart';
import 'package:invoice_app/widgets/widgets.dart';

class AuthSetup extends StatelessWidget {
  const AuthSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    AppConstants.appName,
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Set up your Invoice account',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text('Business Name', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Business Name',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 14),
                Text('Business Type', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Business Type',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 14),
                Text('Country', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Country',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 14),
                Text('Currency', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Currency',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(365, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.upload),
                    label: Text('Upload Logo'),
                  ),
                ),
                const SizedBox(height: 150),
                customButtonLarge(context, 'Continue', () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Mainscreen()),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
