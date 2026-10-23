import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'auth.g.dart';

/// Emits the signed-in [User] (or null) whenever the Firebase session changes.
/// Session-scoped providers (web socket, chat list) watch this to rebuild on
/// login/logout instead of relying on a widget to dispose them.
@Riverpod(keepAlive: true)
Stream<User?> authState(Ref ref) => FirebaseAuth.instance.authStateChanges();

@riverpod
class Auth extends _$Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<User?> build() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> login() async {
    final apiClient = ref.read(apiClientProvider);

    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'Google sign-in is not supported on this platform.',
      );
    }

    state = const AsyncLoading();
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw StateError('Google sign-in did not return an ID token.');
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      await _auth.signInWithCredential(credential);

      await apiClient.post(ApiRoutes.login, {});
    } finally {
      // Signing in swaps the login page out, which can dispose this provider
      // before the request ends.
      if (ref.mounted) state = AsyncData(_auth.currentUser);
    }
  }

  Future<void> logout() async {
    final apiClient = ref.read(apiClientProvider);

    try {
      await apiClient.delete(ApiRoutes.fcm);
    } catch (e) {
      log(e.toString());
    }

    await _googleSignIn.signOut();
    await _auth.signOut();

    if (ref.mounted) state = const AsyncData(null);
  }

  Future<void> delete() async {
    final apiClient = ref.read(apiClientProvider);

    try {
      await apiClient.delete(ApiRoutes.fcm);
      await apiClient.delete(ApiRoutes.me);
    } catch (e) {
      log(e.toString());
    }

    await _googleSignIn.signOut();
    await _auth.signOut();

    if (ref.mounted) state = const AsyncData(null);
  }
}
