import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/pages/chat_page.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/open_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/providers/unread_chats.dart';
import 'package:twist_chat/widgets/show_create_chat_modal.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatSummaries = ref.watch(globalChatProvider);
    final unreadChats =
        ref.watch(unreadChatsProvider).value ?? const <String>{};
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          // An explicit refresh also drops cached chat details, picking up
          // anything missed while the socket was disconnected.
          ref.invalidate(singleChatProvider);
          return ref.refresh(globalChatProvider.future);
        },
        child: switch (chatSummaries) {
          AsyncData(:final value) when value.isNotEmpty => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final chatSummary = value[index];
              return _ChatTile(
                chatSummary: chatSummary,
                unread: unreadChats.contains(chatSummary.chatId),
              );
            },
          ),
          AsyncData() => const _PullableMessage(
            child: Text('No chats available'),
          ),
          AsyncError() => const _PullableMessage(
            child: Text('Oops! Something went wrong'),
          ),
          _ => const _PullableMessage(child: CircularProgressIndicator()),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCreateChatModal(context),
        icon: const Icon(Icons.add),
        label: const Text('New chat'),
      ),
    );
  }
}

/// Centers [child] in a scrollable, so pull-to-refresh also works when there
/// is no list to pull.
class _PullableMessage extends StatelessWidget {
  const _PullableMessage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [SliverFillRemaining(child: Center(child: child))],
    );
  }
}

class _ChatTile extends ConsumerWidget {
  const _ChatTile({required this.chatSummary, required this.unread});

  final ChatSummary chatSummary;
  final bool unread;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.surfaceContainerHighest,
        backgroundImage: chatSummary.chatPhoto != null
            ? CachedNetworkImageProvider(chatSummary.chatPhoto!)
            : null,
      ),
      title: Text(chatSummary.chatName),
      subtitle: Text(
        chatSummary.lastMessage ?? 'No messages',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: unread
          ? Icon(Icons.circle, color: colorScheme.primary, size: 12)
          : null,
      onTap: () {
        ref.read(openChatProvider.notifier).open(chatSummary.chatId);
        ref.read(unreadChatsProvider.notifier).openChat(chatSummary.chatId);

        // Open right away; the chat page shows its own loading state if the
        // details aren't cached.
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ChatPage(
              chatId: chatSummary.chatId,
              isGroup: chatSummary.isGroup,
            ),
          ),
        );
      },
    );
  }
}
