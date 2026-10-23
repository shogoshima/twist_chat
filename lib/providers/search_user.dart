import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'search_user.g.dart';

@riverpod
Future<Profile?> searchUser(Ref ref, String username) async {
  final apiClient = ref.watch(apiClientProvider);

  final json = await apiClient.get('${ApiRoutes.users}/$username');
  if (json['profile'] == null) {
    return null;
  }

  return Profile.fromJson(json['profile']);
}
