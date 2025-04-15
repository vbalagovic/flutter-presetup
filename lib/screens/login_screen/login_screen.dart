import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/flavor_banner.dart';
import 'package:presetup/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:presetup/screens/login_screen/widgets/social_login.dart';
import 'package:presetup/screens/register_screen/register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static const Key anonymousButtonKey = Key('anonymus');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  void getInfo() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'Login Screen seen',
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      signInProvider,
      (_, state) => log("Error"),
    );
    final state = ref.watch(signInProvider);
    final theme = Theme.of(context);

    return FlavorBanner(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primaryColor.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      // App Logo or Title
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.primaryColor.withOpacity(0.1),
                        ),
                        child: Icon(
                          FontAwesomeIcons.shield,
                          size: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        tr('Welcome Back'),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('Sign in to continue'),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: tr('Email'),
                          prefixIcon:
                              const Icon(FontAwesomeIcons.envelope, size: 20),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('Please enter your email');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: tr('Password'),
                          prefixIcon:
                              const Icon(FontAwesomeIcons.lock, size: 20),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('Please enter your password');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: theme.primaryColor,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(tr('Forgot Password?')),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Login Button
                      ElevatedButton.icon(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(signInProvider.notifier)
                                      .signInWithEmailAndPassword(
                                        _emailController.text.trim(),
                                        _passwordController.text,
                                      )
                                      .catchError((onError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(onError.toString())));
                                  });
                                }
                              },
                        icon: const Icon(FontAwesomeIcons.rightToBracket,
                            size: 20),
                        label: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: state.isLoading
                              ? SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : Text(
                                  tr('Sign In'),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Social Login Section
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[400])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              tr('Or continue with'),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey[400])),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Social Login Buttons
                      SocialLogin(),
                      const SizedBox(height: 32),
                      // Register and Skip Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("Don't have an account?"),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.primaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            child: Text(tr('Register')),
                          ),
                        ],
                      ),
                      // Skip Link
                      Center(
                        child: TextButton(
                          key: anonymousButtonKey,
                          onPressed: state.isLoading
                              ? null
                              : () => ref
                                  .read(signInProvider.notifier)
                                  .signInAnonymously(),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[400],
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: Text(
                            tr('Skip for now'),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Social Button Widget
