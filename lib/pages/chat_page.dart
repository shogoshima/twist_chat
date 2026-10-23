import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/common/theme.dart';
import 'package:twist_chat/models/models.dart' as models;
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/filter.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/open_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/fading_text_button.dart';
import 'package:twist_chat/widgets/show_group_chat_modal.dart';
import 'package:twist_chat/widgets/show_modification_modal.dart';
import 'package:uuid/uuid.dart';

final _chatTheme = ChatTheme.fromThemeData(theme);

TextMessage _toTextMessage(models.Message message) => TextMessage(
  id: message.id,
  authorId: message.senderId,
  createdAt: message.sentAt,
  text: message.text,
);

Map<String, models.Profile> _profilesOf(models.ChatDetails? details) => {
  for (final participant in details?.participants ?? const <models.Profile>[])
    participant.id: participant,
};

/// Whether a message with [status] opens a run by the same author.
bool _startsRun(MessageGroupStatus? status) =>
    status == null || status.isFirst || !(status.isMiddle || status.isLast);

/// Whether a message with [status] closes a run by the same author.
bool _endsRun(MessageGroupStatus? status) =>
    status == null || status.isLast || !(status.isFirst || status.isMiddle);

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.chatId, required this.isGroup});

  final String chatId;
  final bool isGroup;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late final ChatController _chatController;
  Map<String, models.Profile> _profiles = {};

  @override
  void initState() {
    super.initState();
    final chatProvider = singleChatProvider(widget.chatId);
    final details = ref.read(chatProvider).value;
    _chatController = InMemoryChatController(
      messages: details?.messages.reversed.map(_toTextMessage).toList(),
    );
    _profiles = _profilesOf(details);

    // A listener sees every state change (several messages can arrive within
    // one frame) and doesn't run on rebuilds unrelated to this chat.
    ref.listenManual(chatProvider, (_, next) {
      if (next.value case final details?) _syncMessages(details);
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _syncMessages(models.ChatDetails details) {
    final profiles = _profilesOf(details);
    if (!mapEquals(profiles, _profiles)) {
      setState(() => _profiles = profiles);
    }

    if (_chatController.messages.isEmpty) {
      _chatController.setMessages(
        details.messages.reversed.map(_toTextMessage).toList(),
      );
      return;
    }

    // details.messages is newest first: walk it until reaching what is
    // already shown. A shown message that differs is the server's copy of one
    // we sent (the text filter may have rewritten it).
    final shown = {for (final m in _chatController.messages) m.id: m};
    final fresh = <TextMessage>[];
    for (final message in details.messages) {
      final incoming = _toTextMessage(message);
      final current = shown[message.id];
      if (current == null) {
        fresh.add(incoming);
      } else if (current != incoming) {
        _chatController.updateMessage(current, incoming);
      } else {
        break;
      }
    }
    _chatController.insertAllMessages(fresh.reversed.toList());
  }

  Future<void> _handleOnMessageSend(String text) async {
    final newMessage = models.WebSocketMessage(
      id: const Uuid().v4(),
      chatId: widget.chatId,
      senderId: auth.FirebaseAuth.instance.currentUser!.uid,
      sentAt: DateTime.now().toUtc(),
      text: text,
      textFilterId: ref.read(activeFilterProvider),
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

  Future<void> _loadOlderMessages() async {
    final moreMessages = await ref
        .read(singleChatProvider(widget.chatId).notifier)
        .loadMore();
    if (!mounted) return;
    // Paging restarts when the chat reloads (e.g. on `refresh_details`), so
    // it can return messages that are already shown.
    final shown = _chatController.messages.map((m) => m.id).toSet();
    await _chatController.insertAllMessages(
      moreMessages
          .where((m) => !shown.contains(m.id))
          .map(_toTextMessage)
          .toList(),
      index: 0,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          // Select only what the title shows: messages in any chat reorder the
          // chat list, and messages in this one change its details.
          final chatSummary = ref.watch(
            globalChatProvider.select(
              (chats) => chats.whenData(
                (summaries) => summaries
                    .where((e) => e.chatId == widget.chatId)
                    .firstOrNull,
              ),
            ),
          );
          final participantNames = ref.watch(
            singleChatProvider(widget.chatId).select(
              (chat) => chat.whenData(
                (details) => details.participants
                    .map((participant) => participant.displayName)
                    .join(', '),
              ),
            ),
          );
          return chatSummary.when(
            data: (summary) {
              if (summary == null) {
                return const Center(child: Text('You are not from this group'));
              }
              return Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    backgroundImage: summary.chatPhoto != null
                        ? CachedNetworkImageProvider(summary.chatPhoto!)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: !summary.isGroup
                        ? FadingTextButton(
                            title: summary.chatName.split(' ')[0],
                          )
                        : switch (participantNames) {
                            AsyncData(:final value) => FadingTextButton(
                              title: summary.chatName,
                              content: value,
                              onTap: () =>
                                  showGroupChatModal(context, widget.chatId),
                            ),
                            AsyncError() => const FadingTextButton(
                              title: 'Error',
                            ),
                            _ => FadingTextButton(
                              title: summary.chatName,
                              content: 'Loading participants...',
                            ),
                          },
                  ),
                ],
              );
            },
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const Text('Loading...'),
          );
        },
      ),
    );
  }

  /// What sits beside the last bubble of a run: the time on one side and, in
  /// groups, the author's avatar on the other.
  Widget _buildSideWidget(
    MessageGroupStatus? groupStatus,
    Message message, {
    required bool showsTime,
    required EdgeInsets timePadding,
  }) {
    if (!_endsRun(groupStatus)) {
      // Keep bubbles aligned with the ones that have an avatar.
      return SizedBox(width: widget.isGroup ? 40 : 0);
    }

    if (showsTime) {
      final createdAt = message.createdAt;
      return Padding(
        padding: timePadding,
        child: Text(
          createdAt == null ? '' : DateFormat.Hm().format(createdAt.toLocal()),
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    if (widget.isGroup) {
      final photoUrl = _profiles[message.authorId]?.photoUrl;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CircleAvatar(
          foregroundImage: photoUrl != null
              ? CachedNetworkImageProvider(photoUrl)
              : null,
          radius: 15,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// The author's name above the first bubble of a run, in groups.
  Widget _buildTopWidget(MessageGroupStatus? groupStatus, Message message) {
    if (!widget.isGroup || !_startsRun(groupStatus)) {
      return const SizedBox.shrink();
    }

    final displayName = _profiles[message.authorId]?.displayName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        displayName ?? 'Deleted',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = singleChatProvider(widget.chatId);
    final hasDetails = ref.watch(chatProvider.select((s) => s.hasValue));
    final hasError = ref.watch(chatProvider.select((s) => s.hasError));

    final user = auth.FirebaseAuth.instance.currentUser!;
    return PopScope(
      // Also covers the system back gesture, not only the app bar button.
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) ref.read(openChatProvider.notifier).close();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: !hasDetails
            ? Center(
                child: hasError
                    ? const Text('Oops! Something went wrong')
                    : const CircularProgressIndicator(),
              )
            : Chat(
                chatController: _chatController,
                builders: Builders(
                  chatAnimatedListBuilder: (context, itemBuilder) {
                    return ChatAnimatedListReversed(
                      itemBuilder: itemBuilder,
                      onEndReached: _loadOlderMessages,
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
                        required isSentByMe,
                      }) => ChatMessage(
                        message: message,
                        index: index,
                        animation: animation,
                        groupStatus: groupStatus,
                        leadingWidget: _buildSideWidget(
                          groupStatus,
                          message,
                          showsTime: isSentByMe,
                          timePadding: const EdgeInsets.only(right: 4),
                        ),
                        trailingWidget: _buildSideWidget(
                          groupStatus,
                          message,
                          showsTime: !isSentByMe,
                          timePadding: const EdgeInsets.only(left: 4),
                        ),
                        topWidget: _buildTopWidget(groupStatus, message),
                        child: child,
                      ),
                  textMessageBuilder:
                      (
                        context,
                        message,
                        index, {
                        groupStatus,
                        required isSentByMe,
                      }) => SimpleTextMessage(
                        message: message,
                        index: index,
                        showTime: false,
                        showStatus: false,
                      ),
                  // Its own Consumer, so changing the text filter rebuilds
                  // only the composer instead of the whole page.
                  composerBuilder: (context) => Consumer(
                    builder: (context, ref, child) {
                      final activeFilter = ref.watch(activeFilterProvider);
                      return Composer(
                        attachmentIcon: activeFilter == 0
                            ? const Icon(Icons.theater_comedy_outlined)
                            : Text(
                                ref
                                    .watch(filterProvider)
                                    .value![activeFilter]
                                    .emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                        inputBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        maxLength: 200,
                        maxLines: 1,
                      );
                    },
                  ),
                ),
                onMessageSend: _handleOnMessageSend,
                resolveUser: (UserID id) async {
                  final profile = _profiles[id];
                  if (profile == null) return null;
                  return User(
                    id: profile.id,
                    name: profile.displayName,
                    imageSource: profile.photoUrl,
                  );
                },
                currentUserId: user.uid,
                onAttachmentTap: () => showModificationModal(context),
                theme: _chatTheme,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
      ),
    );
  }
}
