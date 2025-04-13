import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';
import 'package:twist_chat/providers/global_chat.dart';

part 'single_chat.g.dart';

/// A family provider for a granular chat state notifier, keyed by chatId.
@Riverpod(keepAlive: true)
class SingleChat extends _$SingleChat {
  int _page = 1;
  bool _endReached = false;

  /// Build is called with the chatId as parameter.
  @override
  Future<ChatDetails> build(String chatId) async {
    final apiClient = ref.watch(apiClientProvider);

    final queryParams = {'page': _page.toString()};
    final json = await apiClient.get('${ApiRoutes.chats}/$chatId', queryParams);
    if (json['chat'] == null) {
      throw Exception('Chat not found');
    }

    return ChatDetails.fromJson(json['chat']);
  }

  /// A method to add a new message to this chat.
  void addMessage(Message newMessage) {
    ref
        .read(globalChatProvider.notifier)
        .updateChat(newMessage.chatId, newMessage.text);
        
    final currentState = state.value;
    if (currentState == null) return;

    final updatedMessages = [newMessage, ...currentState.messages];
    final updatedChat = currentState.copyWith(messages: updatedMessages);

    state = AsyncValue.data(updatedChat);
  }

  Future<void> loadMore(String chatId) async {
    if (_endReached) return;

    final currentState = state.value;
    if (currentState == null) return;

    _page += 1;
    final apiClient = ref.watch(apiClientProvider);

    final queryParams = {'page': _page.toString()};
    final json = await apiClient.get('${ApiRoutes.chats}/$chatId', queryParams);
    if (json['chat'] == null) {
      throw Exception('Chat not found');
    }

    final moreChatDetails = ChatDetails.fromJson(json['chat']);
    if (moreChatDetails.messages.isEmpty) _endReached = true;

    final updatedMessages = [
      ...currentState.messages,
      ...moreChatDetails.messages,
    ];
    final updatedChat = currentState.copyWith(messages: updatedMessages);

    state = AsyncValue.data(updatedChat);
  }
}
