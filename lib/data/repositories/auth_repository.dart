import 'package:firebase_auth/firebase_auth.dart';
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
