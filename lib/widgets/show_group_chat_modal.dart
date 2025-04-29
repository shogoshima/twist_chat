import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/search_user.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/widgets/widgets.dart';

Future<void> showGroupChatModal(
  BuildContext context,
  WidgetRef ref,
  String chatId,
) {
  // Watch the providers for chat summary and chat details
  final chatSummaries = ref.watch(globalChatProvider);
  final chatDetails = ref.watch(singleChatProvider(chatId));

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9, // 90% of screen height
            minChildSize: 0.7, // How much it can shrink
            maxChildSize: 0.95, // How much it can expand
            expand: false, // Prevents immediate full height take-over
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header Section with Title & Close Button
                        _buildHeader(context),
                        // Chat Summary Section (chat photo, name, edit option)
                        chatSummaries.when(
                          data: (summaries) {
                            final summary = summaries.firstWhere(
                              (e) => e.chatId == chatId,
                            );
                            return _buildChatSummarySection(
                              context,
                              ref,
                              summary,
                            );
                          },
                          error:
                              (error, stackTrace) => Center(
                                child: Text('Oops! Something went wrong'),
                              ),
                          loading: () => CircularProgressIndicator(),
                        ),
                        // Participants List Card Section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                            child: chatDetails.when(
                              data:
                                  (details) => _buildParticipantsList(details),
                              error:
                                  (error, stackTrace) => Center(
                                    child: Text('Oops! Something went wrong'),
                                  ),
                              loading: () => CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                            child: _buildLeaveButton(chatId),
                          ),
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

/// Build the header with close button.
Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48),
      Text(
        'Group',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

/// Build chat summary section: photo, name, and edit button.
Widget _buildChatSummarySection(
  BuildContext context,
  WidgetRef ref,
  ChatSummary summary,
) {
  return Column(
    children: [
      // Show chat photo (or placeholder)
      summary.chatPhoto != null
          ? CircleAvatar(
            backgroundImage: NetworkImage(summary.chatPhoto!),
            radius: 60,
          )
          : CircleAvatar(backgroundColor: Colors.blueGrey, radius: 60),
      SizedBox(height: 10),
      // Show chat name
      Text(summary.chatName, style: Theme.of(context).textTheme.headlineMedium),
      // 'Edit info' button
      TextButton(
        onPressed: () {
          showEditGroupInfoModal(
            context,
            ref,
            summary.chatId,
            summary.chatName,
          );
        },
        child: Text('Edit info'),
      ),
    ],
  );
}

/// Build the participants ListView with dividers.
Widget _buildParticipantsList(ChatDetails details) {
  return Consumer(
    builder: (context, ref, child) {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: details.participants.length + 1,
        separatorBuilder:
            (context, index) =>
                Divider(height: 0.5, thickness: 0.5, color: Colors.white10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              leading: Icon(Icons.person_add_alt),
              title: Text('Add more participants'),
              onTap: () {
                showAddUserModal(
                  context,
                  ref,
                  details.chatId,
                  details.participants,
                );
              },
            );
          }

          final Profile participant = details.participants[index - 1];
          if (index == details.participants.length) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(participant.photoUrl),
              ),
              title: Text(participant.displayName, overflow: TextOverflow.fade),
              onTap: () async {
                Profile? user = await ref.read(
                  searchUserProvider(participant.username).future,
                );
                if (user != null) {
                  if (!context.mounted) return;
                  showUserDialog(context, user);
                }
              },
            );
          }
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(participant.photoUrl),
            ),
            title: Text(participant.displayName, overflow: TextOverflow.fade),
            onTap: () async {
              Profile? user = await ref.read(
                searchUserProvider(participant.username).future,
              );
              if (user != null) {
                if (!context.mounted) return;
                showUserDialog(context, user);
              }
            },
          );
        },
      );
    },
  );
}

Widget _buildLeaveButton(String chatId) {
  return Consumer(
    builder: (context, ref, child) {
      return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        leading: Icon(Icons.exit_to_app),
        title: Text('Leave group chat'),
        onTap: () {
          showConfirmDialog(
            context,
            'Leave group chat',
            'You won’t be able to see the messages of this group anymore, unless someone add you again.\n\nDo you really want to go ahead?',
            () {
              ref.read(singleChatProvider(chatId).notifier).leaveGroupChat();

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
      );
    },
  );
}
