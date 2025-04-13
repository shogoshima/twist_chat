import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'search_user.g.dart';

@riverpod
class SearchUser extends _$SearchUser {
  @override
  Future<User?> build(String username) async {
    final apiClient = ref.watch(apiClientProvider);

    final json = await apiClient.get("${ApiRoutes.users}/$username");
    if (json['user'] == null) {
      return null;
    }

    return User.fromJson(json['user']);
  }
}
