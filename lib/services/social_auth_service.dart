import 'dart:convert';
import 'dart:developer';
import 'dart:math' as dm;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/utilities/enum.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

class AuthService {
  AuthService(this.ref);

  final FirebaseAuth auth = FirebaseAuth.instance;
  late AuthResultStatus status;
  late WidgetRef ref;

  Future<AuthResultStatus> googleSignIn() async {
    log("google sign in -----");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    log("google sign in");
    try {
      EasyLoading.show();
      final googleUser = await googleSignIn.signIn();
      log(googleUser!.email);

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      status = await ref
          .read(signInProvider.notifier)
          .signInWithCredential(credential);

      return status;
    } catch (error) {
      log("$error");
      EasyLoading.dismiss();
      return AuthResultStatus.undefined;
    }
  }

  Future<AuthResultStatus> facebookSignIn() async {
    log("facebook sign in -----");
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      EasyLoading.show();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.i.getUserData();
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        log("facebook status $userData");
        status = await ref
            .read(signInProvider.notifier)
            .signInWithCredential(credential);
      } else if (result.status == LoginStatus.cancelled) {
        return AuthResultStatus.cancelled;
      } else {
        log("facebook status ${result.status}");
        log("facebook message ${result.message}");
        status = AuthResultStatus.undefined;
      }

      return status;
    } catch (error) {
      log("$error");
      EasyLoading.dismiss();
      return AuthResultStatus.undefined;
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = dm.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<AuthResultStatus> appleSignIn() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      final appleResult = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);
      EasyLoading.show();
      final credential = OAuthProvider("apple.com").credential(
        idToken: appleResult.identityToken,
        rawNonce: rawNonce,
        accessToken: appleResult.authorizationCode,
      );
      status = await ref
          .read(signInProvider.notifier)
          .signInWithCredential(credential);

      return status;
    } on SignInWithAppleAuthorizationException catch (error) {
      inspect(error);
      if (error.code == AuthorizationErrorCode.unknown ||
          error.code == AuthorizationErrorCode.canceled) {
        return AuthResultStatus.cancelled;
      }
      EasyLoading.dismiss();
      return AuthResultStatus.undefined;
    } catch (error) {
      EasyLoading.dismiss();
      return AuthResultStatus.undefined;
    }
  }

  /* Future deleteUser() async {
    try {
      await auth.currentUser?.reload().then((value) {
        FirebaseService().deleteUserData();
        return auth.currentUser?.delete();
      });
    } on FirebaseAuthException catch (error) {
      log("$error");
      if (error.code == "requires-recent-login") {
        return AuthResultStatus.needsLogin;
      }
      return AuthResultStatus.undefined;
    }
  } */

  /*Future deleteUser() async {
    try {
      await auth.currentUser?.reload().then((value) {
        return auth.currentUser?.delete();
      });
    } on FirebaseAuthException catch (error) {
      log("$error");
      if (error.code == "requires-recent-login") {
        return AuthResultStatus.needsLogin;
      }
      return AuthResultStatus.undefined;
    }
  } */
}
