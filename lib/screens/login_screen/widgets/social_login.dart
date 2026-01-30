import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/services/social_auth_service.dart';
import 'package:presetup/utilities/auth_handler.dart';
import 'package:presetup/utilities/enum.dart';
import 'package:presetup/utilities/router.dart';
import 'package:presetup/widgets/fp_button.dart';

class SocialLogin extends ConsumerWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);

    double sizeW = MediaQuery.of(context).size.width / 100;

    void handleSocialLogin(AuthResultStatus status) {
      EasyLoading.dismiss();
      if (status == AuthResultStatus.successful) {
      } else if (status == AuthResultStatus.cancelled) {
        //
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: (() => Navigator.pop(context)),
              child: AlertDialog(
                title: const Center(child: Text('Failed')),
                content: Text(
                  AuthExceptionHandler.generateExceptionMessage(status),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      }
    }

    Future<void> redirectOnLogin() async {
      // Fetch user data from backend if needed
      ref.read(routerProvider).go("/home/dashboard");
    }

    Future<AuthResultStatus> signInWithGoogle() async {
      final AuthResultStatus result = await AuthService(ref).googleSignIn();

      if (result == AuthResultStatus.successful) {
        await redirectOnLogin();
      }
      handleSocialLogin(result);

      return result;
    }

    Future<AuthResultStatus> signInWithFacebook() async {
      log("fcb sign in");
      final AuthResultStatus result = await AuthService(ref).facebookSignIn();

      if (result == AuthResultStatus.successful) {
        await redirectOnLogin();
      }
      handleSocialLogin(result);

      return result;
    }

    Future<AuthResultStatus> signInWithApple() async {
      log("apple sign in");
      final AuthResultStatus result = await AuthService(ref).appleSignIn();

      log(result.toString());

      if (result == AuthResultStatus.successful) {
        await redirectOnLogin();
      }
      handleSocialLogin(result);
      return result;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Login Button
        _SocialButton(
          icon: FontAwesomeIcons.google,
          color: Colors.red,
          onPressed: state.isLoading
              ? null
              : () async {
                  await signInWithGoogle();
                },
        ),
        const SizedBox(width: 20),
        // Facebook Login Button
        _SocialButton(
          icon: FontAwesomeIcons.facebook,
          color: Colors.blue,
          onPressed: state.isLoading
              ? null
              : () async {
                  await signInWithFacebook();
                },
        ),
        const SizedBox(width: 20),
        // Apple Login Button
        _SocialButton(
          icon: FontAwesomeIcons.apple,
          color: Colors.black,
          onPressed: state.isLoading
              ? null
              : () async {
                  await signInWithApple();
                },
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Icon(icon, size: 24, color: color),
        ),
      ),
    );
  }
}
