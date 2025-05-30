import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/common/theme.dart';
import 'package:twist_chat/models/models.dart' as models;
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/filter.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/open_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/show_group_chat_modal.dart';
import 'package:twist_chat/widgets/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId;
  final List<TextMessage> initialMessages;
  final Map<String, models.Profile> profiles;
  final bool isGroup;
  const ChatPage({
    super.key,
    required this.chatId,
    required this.initialMessages,
    required this.profiles,
    required this.isGroup,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late final ChatController _chatController;

  @override
  void initState() {
    _chatController = InMemoryChatController(messages: widget.initialMessages);
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _handleOnMessageSend(String text) async {
    final newMessage = models.WebSocketMessage(
      id: Uuid().v4(),
      chatId: widget.chatId,
      senderId: auth.FirebaseAuth.instance.currentUser!.uid,
      sentAt: DateTime.now().toUtc(),
      text: text,
      textFilterId: ref.watch(activeFilterProvider),
    );

    ref.read(webSocketProvider.notifier).sendMessage(newMessage);

    await _chatController.insertMessage(
      TextMessage(
        id: newMessage.id,
        authorId: newMessage.senderId,
        createdAt: newMessage.sentAt,
        text: text,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          ref.read(openChatProvider.notifier).close();
          Navigator.of(context).pop(); // Optional: go back
        },
      ),
      title: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<List<models.ChatSummary>> chatSummaries = ref.watch(
            globalChatProvider,
          );
          final AsyncValue<models.ChatDetails> chatDetails = ref.watch(
            singleChatProvider(widget.chatId),
          );
          return chatSummaries.when(
            data: (summaries) {
              final summary = summaries.firstWhere(
                (e) => e.chatId == widget.chatId,
                orElse:
                    () => models.ChatSummary(
                      chatId: '',
                      chatName: '',
                      isGroup: false,
                    ),
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

  String dateFormat(DateTime? datetime) {
    if (datetime == null) return '';
    return DateFormat.Hm().format(datetime.toLocal());
  }

  Widget buildTrailingWidget(
    MessageGroupStatus? groupStatus,
    Message message,
    String userId,
  ) {
    bool? isFirst = groupStatus?.isFirst;
    bool? isLast = groupStatus?.isLast;
    bool? isMiddle = groupStatus?.isMiddle;
    bool? isAlone = (isFirst != true && isLast != true && isMiddle != true);

    if (isLast != true && isAlone != true) {
      if (widget.isGroup) {
        return const SizedBox(width: 40);
      } else {
        return const SizedBox();
      }
    }

    if (message.authorId != userId) {
      return Padding(
        padding: EdgeInsets.only(left: 4),
        child: Text(
          dateFormat(message.createdAt),
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      );
    }

    if (widget.isGroup) {
      final photoUrl = widget.profiles[message.authorId]?.photoUrl;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: CircleAvatar(
          foregroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          radius: 15,
        ),
      );
    }

    return const SizedBox();
  }

  Widget buildLeadingWidget(
    MessageGroupStatus? groupStatus,
    Message message,
    String userId,
  ) {
    bool? isFirst = groupStatus?.isFirst;
    bool? isLast = groupStatus?.isLast;
    bool? isMiddle = groupStatus?.isMiddle;
    bool? isAlone = (isFirst != true && isLast != true && isMiddle != true);

    if (isLast != true && isAlone != true) {
      if (widget.isGroup) {
        return const SizedBox(width: 40);
      } else {
        return const SizedBox();
      }
    }

    if (message.authorId == userId) {
      return Padding(
        padding: EdgeInsets.only(right: 4),
        child: Text(
          dateFormat(message.createdAt),
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      );
    }

    if (widget.isGroup) {
      final photoUrl = widget.profiles[message.authorId]?.photoUrl;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CircleAvatar(
          foregroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          radius: 15,
        ),
      );
    }

    return const SizedBox();
  }

  Widget buildTopWidget(
    MessageGroupStatus? groupStatus,
    Message message,
    String userId,
  ) {
    bool? isFirst = groupStatus?.isFirst;
    bool? isLast = groupStatus?.isLast;
    bool? isMiddle = groupStatus?.isMiddle;
    bool? isAlone = (isFirst != true && isLast != true && isMiddle != true);

    // Quando não é o primeiro, não mostro nada
    if ((isFirst != true && isAlone != true) || !widget.isGroup) {
      return const SizedBox();
    }

    final displayName = widget.profiles[message.authorId]?.displayName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(displayName ?? 'Deleted', style: TextStyle(fontSize: 13)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final singleChatAsync = ref.watch(singleChatProvider(widget.chatId));
    singleChatAsync.whenData((chatDetails) async {
      // if (_chatController.messages.isEmpty) return;
      // Optional: Sync messages if needed
      final lastMessage = chatDetails.messages[0];
      final newMessage = TextMessage(
        id: lastMessage.id,
        authorId: lastMessage.senderId,
        createdAt: lastMessage.sentAt,
        text: lastMessage.text,
      );
      if (lastMessage.id == _chatController.messages.last.id) {
        await _chatController.updateMessage(
          _chatController.messages.last,
          newMessage,
        );
      } else {
        await _chatController.insertMessage(newMessage);
      }
    });

    final user = auth.FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Chat(
        chatController: _chatController,
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedListReversed(
              itemBuilder: itemBuilder,
              onEndReached: () async {
                final moreMessages =
                    await ref
                        .read(singleChatProvider(widget.chatId).notifier)
                        .loadMore();
                List<TextMessage> messages =
                    moreMessages
                        .map(
                          (element) => TextMessage(
                            id: element.id,
                            authorId: element.senderId,
                            text: element.text,
                            createdAt: element.sentAt,
                          ),
                        )
                        .toList();
                await _chatController.insertAllMessages(messages, index: 0);
              },
            );
          },
          chatMessageBuilder:
              (
                context,
                message,
                index,
                animation,
                child, {
                groupStatus,
                isRemoved,
              }) => ChatMessage(
                message: message,
                index: index,
                animation: animation,
                groupStatus: groupStatus,
                leadingWidget: buildLeadingWidget(
                  groupStatus,
                  message,
                  user.uid,
                ),
                trailingWidget: buildTrailingWidget(
                  groupStatus,
                  message,
                  user.uid,
                ),
                topWidget: buildTopWidget(groupStatus, message, user.uid),
                child: child,
              ),
          textMessageBuilder:
              (context, message, index) => SimpleTextMessage(
                message: message,
                index: index,
                showTime: false,
                showStatus: false,
              ),
          composerBuilder:
              (context) => Composer(
                attachmentIcon:
                    ref.watch(activeFilterProvider) == 0
                        ? Icon(Icons.theater_comedy_outlined)
                        : Text(
                          ref
                              .watch(filterProvider)
                              .value![ref.watch(activeFilterProvider)]
                              .emoji,
                          style: TextStyle(fontSize: 20),
                        ),
                maxLength: 200,
              ),
        ),
        onMessageSend: _handleOnMessageSend,
        resolveUser: (UserID id) async {
          if (widget.profiles.containsKey(id)) {
            final profile = widget.profiles[id]!;
            return User(
              id: profile.id,
              name: profile.displayName,
              imageSource: profile.photoUrl,
            );
          } else {
            return null;
          }
        },
        currentUserId: user.uid,
        onAttachmentTap: () {
          showModificationModal(context, ref);
        },
        theme: ChatTheme.fromThemeData(theme),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
