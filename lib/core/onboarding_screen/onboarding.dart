import 'package:flutter/material.dart';

import 'package:invoice_app/constants/app_constants.dart';
import 'package:invoice_app/core/auth/screen/signup_screen.dart';
import 'package:invoice_app/widgets/widgets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentStep = 0;

  void nextStep() {
    if (currentStep < AppConstants.onboardingTexts.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      // Navigate to login or main app
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final String currentImage = isDarkMode
        ? AppConstants.onboardingImageLight
        : AppConstants.onboardingImageLight;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: [
              Text(
                'Invoice',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Expanded(child: Center(child: Image.asset(currentImage))),
              const SizedBox(height: 15),
              Text(
                'Invoice in seconds',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppConstants.onboardingTexts[currentStep],
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Progress indicator with 4 segments
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: LinearProgressIndicator(
                          value: index < currentStep
                              ? 1.0
                              : index == currentStep
                              ? 0.5
                              : 0.0,
                          minHeight: 4,
                          backgroundColor: theme.colorScheme.primary
                              .withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      if (index != 3) const SizedBox(width: 8),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButtonSmall(
                    context,
                    currentStep == AppConstants.onboardingTexts.length - 1
                        ? "Let's Start"
                        : 'Next',
                    nextStep,
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
