import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/widgets/modal_header.dart';
import 'package:twist_chat/widgets/show_add_user_modal.dart';
import 'package:twist_chat/widgets/show_dialog.dart';
import 'package:twist_chat/widgets/show_edit_group_info_modal.dart';
import 'package:twist_chat/widgets/show_user_dialog.dart';

Future<void> showGroupChatModal(BuildContext context, String chatId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => _GroupChatSheet(chatId: chatId),
  );
}

class _GroupChatSheet extends ConsumerWidget {
  const _GroupChatSheet({required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatSummary = ref.watch(
      globalChatProvider.select(
        (chats) => chats.whenData(
          (summaries) => summaries.where((e) => e.chatId == chatId).firstOrNull,
        ),
      ),
    );
    final chatDetails = ref.watch(singleChatProvider(chatId));
    final cardColor = Theme.of(context).colorScheme.surfaceContainerHigh;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.7,
      maxChildSize: 0.95,
      // Size to the content instead of taking the full height right away.
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ModalHeader(title: 'Group'),
                chatSummary.when(
                  data: (summary) => summary == null
                      ? const SizedBox.shrink()
                      : _ChatSummarySection(summary: summary),
                  error: (error, stackTrace) =>
                      const Center(child: Text('Oops! Something went wrong')),
                  loading: () => const CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: cardColor,
                    child: chatDetails.when(
                      data: (details) => _ParticipantsList(details: details),
                      error: (error, stackTrace) => const Center(
                        child: Text('Oops! Something went wrong'),
                      ),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: cardColor,
                    child: _LeaveGroupTile(chatId: chatId),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Chat photo, name, and edit button.
class _ChatSummarySection extends StatelessWidget {
  const _ChatSummarySection({required this.summary});

  final ChatSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          backgroundImage: summary.chatPhoto != null
              ? CachedNetworkImageProvider(summary.chatPhoto!)
              : null,
        ),
        const SizedBox(height: 10),
        Text(summary.chatName, style: theme.textTheme.headlineMedium),
        TextButton(
          onPressed: () =>
              showEditGroupInfoModal(context, summary.chatId, summary.chatName),
          child: const Text('Edit info'),
        ),
      ],
    );
  }
}

class _ParticipantsList extends StatelessWidget {
  const _ParticipantsList({required this.details});

  final ChatDetails details;

  static const _topShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
  );
  static const _bottomShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    final participants = details.participants;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: participants.length + 1,
      separatorBuilder: (context, index) =>
          const Divider(height: 0.5, thickness: 0.5),
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            shape: _topShape,
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Add more participants'),
            onTap: () =>
                showAddUserModal(context, details.chatId, participants),
          );
        }

        final participant = participants[index - 1];
        return ListTile(
          shape: index == participants.length ? _bottomShape : null,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(participant.photoUrl),
          ),
          title: Text(participant.displayName, overflow: TextOverflow.fade),
          onTap: () => showUserDialog(context, participant),
        );
      },
    );
  }
}

class _LeaveGroupTile extends ConsumerWidget {
  const _LeaveGroupTile({required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Leave group chat'),
      onTap: () async {
        final confirmed = await showConfirmDialog(
          context,
          'Leave group chat',
          'You won’t be able to see the messages of this group anymore, unless someone add you again.\n\nDo you really want to go ahead?',
        );
        if (!confirmed || !context.mounted) return;

        final messenger = ScaffoldMessenger.of(context);
        try {
          await ref.read(singleChatProvider(chatId).notifier).leaveGroupChat();
        } catch (error) {
          messenger.showSnackBar(SnackBar(content: Text('Error: $error')));
          return;
        }
        if (!context.mounted) return;
        // Close this sheet and the chat page beneath it.
        Navigator.of(context)
          ..pop()
          ..pop();
      },
    );
  }
}
