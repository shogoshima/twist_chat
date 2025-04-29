import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'profile.g.dart';

@riverpod
Future<Profile?> profile(Ref ref) async {
  final apiClient = ref.watch(apiClientProvider);

  final json = await apiClient.get(ApiRoutes.me);

  return Profile.fromJson(json['profile']);
}
