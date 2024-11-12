import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:presetup/utilities/auth_handler.dart';
import 'package:presetup/utilities/enum.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    debugPrint("statement $email");
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Specific handling for FirebaseAuthException
      debugPrint("Firebase Auth error: ${e.message}");
      rethrow; // rethrow if you want the error to propagate
    } catch (e) {
      // Generic error catch
      debugPrint("General error: $e");
      rethrow;
    }
  }

  Future<dynamic> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Specific handling for FirebaseAuthException
      debugPrint("Firebase Auth error: ${e.message}");
      rethrow; // rethrow if you want the error to propagate
    } catch (e) {
      // Generic error catch
      debugPrint("General error: $e");
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      // Specific handling for FirebaseAuthException
      debugPrint("Firebase Auth error: ${e.message}");
      rethrow; // rethrow if you want the error to propagate
    } catch (e) {
      // Generic error catch
      debugPrint("General error: $e");
      rethrow;
    }
  }

  String? getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Method For Social logins
  Future<AuthResultStatus> signInWithCredential(
      OAuthCredential credential) async {
    AuthResultStatus status;
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }
    return status;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
