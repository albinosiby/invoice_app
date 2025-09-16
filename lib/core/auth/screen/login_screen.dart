import 'package:flutter/material.dart';
import 'package:invoice_app/core/auth/screen/signup_screen.dart';
import 'package:invoice_app/core/mainScreen/screen/mainScreen.dart';
import 'package:invoice_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'invoice_app',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Welcome Back',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Login to your invoice_app account',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Email', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Password', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 6),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(color: theme.hintColor),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Forgot password?', style: theme.textTheme.bodyLarge),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Reset your password',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                customButtonLarge(context, 'Login', () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Mainscreen()),
                  );
                }),

                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or better yet'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: OutlinedButton.icon(
                    icon: Icon(
                      Icons.g_mobiledata,
                      color: Colors.blue,
                      size: 28,
                    ),
                    label: Text(
                      'Continue with Google',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.dividerColor,
                      side: BorderSide(color: theme.hintColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Mainscreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 354,
                  height: 56,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.apple, color: Colors.blue, size: 24),
                    label: Text(
                      'Continue with Apple',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.dividerColor,
                      side: BorderSide(color: theme.hintColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Mainscreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
