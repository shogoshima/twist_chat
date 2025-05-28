import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/providers/api_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth.g.dart';

@riverpod
class Auth extends _$Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User?> build() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> login() async {
    final apiClient = ref.read(apiClientProvider);

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);

    await apiClient.post(ApiRoutes.login, {});

    state = AsyncData(_auth.currentUser);
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

    state = const AsyncData(null);
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

    state = const AsyncData(null);
  }
}
