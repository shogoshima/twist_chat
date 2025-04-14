import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/chat_details.dart' as models;
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/google_auth.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId;
  final String chatName;
  final String? chatPhotoUrl;
  final bool isGroup;
  const ChatPage({
    super.key,
    required this.chatId,
    required this.chatName,
    this.chatPhotoUrl,
    required this.isGroup,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  void _handleSendPressed(types.PartialText message) {
    if (message.text.length > 100) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Message too long.')));
      return;
    }

    final newMessage = WebSocketMessage(
      id: Uuid().v4(),
      chatId: widget.chatId,
      senderId: ref.watch(googleAuthProvider).value!.id,
      sentAt: DateTime.now().toUtc(),
      text: message.text,
      textFilterId: ref.watch(activeFilterProvider),
    );

    ref.read(webSocketProvider.notifier).sendMessage(newMessage);
  }

  List<types.TextMessage> _formatMessages(models.ChatDetails? chatDetails) {
    if (chatDetails == null) {
      return [];
    }

    final messages = chatDetails.messages;
    final participants = chatDetails.participants;
    final Map<String, String> names = {};
    final Map<String, String?> photos = {};
    for (final participant in participants) {
      names[participant.id] = participant.name;
      photos[participant.id] = participant.photoUrl;
    }
    final messagesFormatted = messages.map(
      (message) => types.TextMessage(
        author: types.User(
          id: message.senderId,
          firstName: names[message.senderId] ?? 'Deleted User',
          imageUrl: photos[message.senderId],
        ),
        id: message.id,
        text: message.text,
        createdAt: message.sentAt.millisecondsSinceEpoch,
      ),
    );
    return messagesFormatted.toList();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<ChatDetails> chatDetails = ref.watch(
      singleChatProvider(widget.chatId),
    );
    final user = ref.watch(googleAuthProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.chatPhotoUrl != null
                ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.chatPhotoUrl!),
                )
                : CircleAvatar(backgroundColor: Colors.blueGrey),
            const SizedBox(width: 8),
            widget.isGroup
                ? Text(widget.chatName)
                : Text(widget.chatName.split(' ')[0]),
          ],
        ),
      ),
      body: Center(
        child: switch (chatDetails) {
          AsyncData(:final value) => Chat(
            messages: _formatMessages(value),
            onSendPressed: _handleSendPressed,
            user: types.User(id: user!.id),
            showUserAvatars: widget.isGroup,
            showUserNames: widget.isGroup,
            onEndReached: () async {
              await ref
                  .read(singleChatProvider(widget.chatId).notifier)
                  .loadMore(widget.chatId);
            },
            onAttachmentPressed: () {
              showModificationModal(context, ref);
            },
            theme: DefaultChatTheme(
              secondaryColor: Theme.of(context).colorScheme.surfaceContainer,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              sentMessageBodyTextStyle: TextStyle(fontSize: 14),
              receivedMessageBodyTextStyle: TextStyle(fontSize: 14),
              attachmentButtonIcon: Icon(Icons.theater_comedy_outlined),
            ),
          ),
          AsyncError() => Text('Oops! Something went wrong when loading chat'),
          (_) => CircularProgressIndicator(),
        },
      ),
    );
  }
}
