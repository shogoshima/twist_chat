import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'global_chat.g.dart';

@riverpod
class GlobalChat extends _$GlobalChat {
  @override
  Future<List<ChatSummary>> build() async {
    final apiClient = ref.watch(apiClientProvider);

    // Fetch all the chats (metadata)
    final json = await apiClient.get(ApiRoutes.summaries);
    if (json['chats'] == null) {
      return [];
    }

    return (json['chats'] as List)
        .map((chat) => ChatSummary.fromJson(chat))
        .toList();
  }

  Future<void> fetchNewChat(String chatId) async {
    final apiClient = ref.watch(apiClientProvider);

    // Fetch all the chats (metadata)
    final json = await apiClient.get('${ApiRoutes.summaries}/$chatId');
    if (json['chat'] == null) {
      return;
    }

    final newChat = ChatSummary.fromJson(json['chat']);

    state = AsyncValue.data([newChat, ...state.value ?? []]);
  }

  Future<void> createNewChat(String username) async {
    final apiClient = ref.watch(apiClientProvider);

    // Fetch all the chats (metadata)
    final json = await apiClient.post('${ApiRoutes.chats}/$username', {});
    if (json['chat'] == null) {
      return;
    }

    final newChat = ChatSummary.fromJson(json['chat']);

    state = AsyncValue.data([newChat, ...state.value ?? []]);
  }

  void updateChat(String chatId, String lastMessage) {
    final currentState = state.value;
    print(currentState);

    if (currentState == null) return;

    final updated = List<ChatSummary>.from(currentState);

    // Find the chat and bring it to the front
    final index = updated.indexWhere((chat) => chat.chatId == chatId);
    if (index != -1) {
      final chat = updated.removeAt(index);
      final newChat = chat.copyWith(lastMessage: lastMessage);
      updated.insert(0, newChat);
    }

    state = AsyncValue.data(updated);
  }
}
