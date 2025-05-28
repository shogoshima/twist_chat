import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/chat_details.dart' as models;
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/show_group_chat_modal.dart';
import 'package:twist_chat/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId;
  const ChatPage({super.key, required this.chatId});

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
      senderId: FirebaseAuth.instance.currentUser!.uid,
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
      names[participant.id] = participant.displayName;
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

  AppBar _buildAppBar() {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<List<ChatSummary>> chatSummaries = ref.watch(
            globalChatProvider,
          );
          final AsyncValue<ChatDetails> chatDetails = ref.watch(
            singleChatProvider(widget.chatId),
          );
          return chatSummaries.when(
            data: (summaries) {
              final summary = summaries.firstWhere(
                (e) => e.chatId == widget.chatId,
                orElse:
                    () => ChatSummary(chatId: '', chatName: '', isGroup: false),
              );
              if (summary.chatId == '') {
                return Center(child: Text('You are not from this group'));
              }
              return Row(
                children: [
                  summary.chatPhoto != null
                      ? CircleAvatar(
                        backgroundImage: NetworkImage(summary.chatPhoto!),
                      )
                      : CircleAvatar(backgroundColor: Colors.black),
                  const SizedBox(width: 8),
                  summary.isGroup
                      ? Expanded(
                        child: switch (chatDetails) {
                          AsyncData(:final value) => FadingTextButton(
                            title: summary.chatName,
                            content: value.participants
                                .map((participant) => participant.displayName)
                                .join(', '),
                            onTap: () async {
                              await showGroupChatModal(
                                context,
                                ref,
                                widget.chatId,
                              );
                            },
                          ),
                          AsyncError() => FadingTextButton(title: 'Error'),
                          (_) => FadingTextButton(
                            title: summary.chatName,
                            content: 'Loading participants...',
                          ),
                        },
                      )
                      : Expanded(
                        child: FadingTextButton(
                          title: summary.chatName.split(' ')[0],
                        ),
                      ),
                ],
              );
            },
            error: (error, stackTrace) => Text('Error'),
            loading: () => Text('Loading...'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<ChatDetails> chatDetails = ref.watch(
      singleChatProvider(widget.chatId),
    );
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: switch (chatDetails) {
          AsyncData(:final value) => Chat(
            messages: _formatMessages(value),
            onSendPressed: _handleSendPressed,
            user: types.User(id: user.uid),
            showUserAvatars: value.participants.length > 2,
            showUserNames: value.participants.length > 2,
            onEndReached: () async {
              await ref
                  .read(singleChatProvider(widget.chatId).notifier)
                  .loadMore();
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
