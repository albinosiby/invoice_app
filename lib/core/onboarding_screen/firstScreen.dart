import 'package:flutter/material.dart';
import 'package:invoice/constants/app_constants.dart';
import 'package:invoice/core/auth/screen/login_screen.dart';
import 'package:invoice/core/onboarding_screen/onboarding.dart';
import 'package:invoice/widgets/widgets.dart';

class Firstscreen extends StatelessWidget {
  const Firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String currentImage = isDarkMode
        ? AppConstants.onboardingImageLight
        : AppConstants.onboardingImageLight;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Invoice',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Expanded(child: Center(child: Image.asset(currentImage))),
              const SizedBox(height: 24),
              Text(
                AppConstants.firstScreenText,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              customButtonLarge(context, 'Get Started', () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnboardingPage()),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: theme.textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Log In',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
