import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'google_auth.g.dart';

@riverpod
class GoogleAuth extends _$GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
    serverClientId:
        '830238838384-2stg8g2od1tmudfcfo0f6psbalsuct31.apps.googleusercontent.com',
  );

  @override
  Future<User?> build() async {
    final apiClient = ref.watch(apiClientProvider);

    final json = await apiClient.get(ApiRoutes.me);

    if (json['user'] == null) {
      await apiClient.removeToken();
      return null;
    }

    return User.fromJson(json['user']);
  }

  Future<void> login() async {
    final apiClient = ref.watch(apiClientProvider);

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    await apiClient.setToken(googleAuth.idToken!);

    try {
      final json = await apiClient.post(ApiRoutes.login, {});

      apiClient.setToken(json['token']);

      state = AsyncData(User.fromJson(json['user']));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout() async {
    final apiClient = ref.read(apiClientProvider);

    await apiClient.removeToken();
    await _googleSignIn.signOut();

    state = const AsyncData(null);
  }
}
