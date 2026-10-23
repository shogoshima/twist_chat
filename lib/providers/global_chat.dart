import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';
import 'package:twist_chat/providers/auth.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/providers/web_socket.dart';

part 'global_chat.g.dart';

/// Session-wide chat list: kept alive for the whole session and rebuilt
/// whenever the signed-in user changes.
@Riverpod(keepAlive: true)
class GlobalChat extends _$GlobalChat {
  @override
  Future<List<ChatSummary>> build() async {
    final user = await ref.watch(authStateProvider.future);
    if (user == null) {
      // Signed out: drop every cached chat so nothing leaks into the next session.
      ref.invalidate(singleChatProvider);
      return [];
    }

    final apiClient = ref.watch(apiClientProvider);

    // Fetch all the chats (metadata)
    final json = await apiClient.get(ApiRoutes.summaries);
    if (json['chats'] == null) {
      return [];
    }

    // Cached chat details are left alone: the socket keeps them current, and
    // the server asks for `refresh_details` when one actually changed.
    return (json['chats'] as List)
        .map((chat) => ChatSummary.fromJson(chat))
        .toList();
  }

  Future<void> fetchNewChat(String chatId) async {
    final apiClient = ref.read(apiClientProvider);

    // Fetch all the chats (metadata)
    final json = await apiClient.get('${ApiRoutes.summaries}/$chatId');
    if (json['chat'] == null) {
      return;
    }

    final newChat = ChatSummary.fromJson(json['chat']);

    state = AsyncValue.data([newChat, ...state.value ?? []]);
  }

  Future<void> createNewSingleChat(String username) async {
    final apiClient = ref.read(apiClientProvider);

    // post and receive the new chat (metadata)
    final json = await apiClient.post(ApiRoutes.dm, {'username': username});
    if (json['chat'] == null) {
      return;
    }

    final newChat = ChatSummary.fromJson(json['chat']);

    final newAction = WebSocketAction(
      chatId: newChat.chatId,
      type: 'refresh_details',
    );
    ref.read(webSocketProvider.notifier).sendAction(newAction);

    state = AsyncValue.data([newChat, ...state.value ?? []]);
  }

  Future<void> createNewGroupChat(List<String> usernames, String name) async {
    final apiClient = ref.read(apiClientProvider);

    final json = await apiClient.post(ApiRoutes.group, {
      'usernames': usernames,
      'name': name,
    });
    if (json['chat'] == null) {
      return;
    }

    final newChat = ChatSummary.fromJson(json['chat']);

    final newAction = WebSocketAction(
      chatId: newChat.chatId,
      type: 'refresh_details',
    );
    ref.read(webSocketProvider.notifier).sendAction(newAction);

    state = AsyncValue.data([newChat, ...state.value ?? []]);
  }

  void updateChat(String chatId, String lastMessage) {
    final currentState = state.value;

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

  Future<void> updateGroupChatInfo(String chatId, String chatName) async {
    final apiClient = ref.read(apiClientProvider);

    await apiClient.put('${ApiRoutes.group}/$chatId', {'name': chatName});

    final newAction = WebSocketAction(chatId: chatId, type: 'refresh_summary');
    ref.read(webSocketProvider.notifier).sendAction(newAction);
  }

  void deleteChatFromList(String chatId) {
    final currentState = state.value;

    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.where((chat) => chat.chatId != chatId).toList(),
    );
  }
}
