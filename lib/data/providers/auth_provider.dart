import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presetup/data/repositories/auth_repository.dart';
import 'package:presetup/utilities/enum.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final signInProvider =
    AsyncNotifierProvider<SignInNotifier, void>(SignInNotifier.new);

class SignInNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    //
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<dynamic> signInWithEmailAndPassword(email, password) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();

    try {
      // Attempt sign-in
      final result =
          await authRepository.signInWithEmailAndPassword(email, password);

      // On success, return the result
      state = AsyncData(result);
    } catch (error, stackTrace) {
      // Firebase Auth or any other error handling
      debugPrint("Sign-in failed with error: $error");

      // Handling FirebaseAuthException explicitly for better understanding of errors
      if (error is FirebaseAuthException) {
        debugPrint("Firebase Auth Error: ${error.message}");
        state = AsyncError(error, stackTrace);
        throw Exception(error.message);
      }

      // Set state with the error and stack trace
      state = AsyncError(error, stackTrace);
    }
  }

  Future<dynamic> createUserWithEmailAndPassword(email, password) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();

    try {
      // Attempt sign-in
      final result =
          await authRepository.createUserWithEmailAndPassword(email, password);

      // On success, return the result
      state = AsyncData(result);
    } catch (error, stackTrace) {
      debugPrint("Sign-up failed with error: $error");

      if (error is FirebaseAuthException) {
        debugPrint("Firebase Auth Error: ${error.message}");
        state = AsyncError(error, stackTrace);
        throw Exception(error.message);
      }

      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> resetPassword(email) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    try {
      final result = await authRepository.resetPassword(email);

      state = AsyncData(result);
    } catch (error, stackTrace) {
      debugPrint("Sign-up failed with error: $error");

      if (error is FirebaseAuthException) {
        debugPrint("Firebase Auth Error: ${error.message}");
        state = AsyncError(error, stackTrace);
        throw Exception(error.message);
      }

      state = AsyncError(error, stackTrace);
    }
  }

  Future<AuthResultStatus> signInWithCredential(credential) async {
    final authRepository = ref.read(authRepositoryProvider);
    try {
      return await authRepository.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signOut();
  }
}
