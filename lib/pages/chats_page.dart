import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/pages/chat_page.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/search_user.dart';
import 'package:twist_chat/widgets/widgets.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ChatSummary>> chatSummaries = ref.watch(
      globalChatProvider,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Search for a user',
              border: OutlineInputBorder(),
              hintText: 'Enter username',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final username = _usernameController.text;
                  if (username.isNotEmpty) {
                    try {
                      // Read the future from the provider and await it.
                      final userData = await ref.read(
                        searchUserProvider(username).future,
                      );

                      if (!context.mounted) return;
                      if (userData != null) {
                        await showUserDialog(context, userData, (
                          username,
                        ) async {
                          try {
                            await ref
                                .read(globalChatProvider.notifier)
                                .createNewChat(username);
                            _usernameController.text = "";
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User not found.')),
                        );
                      }
                    } catch (error) {
                      // Handle error here, for example:
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $error')));
                    }
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: switch (chatSummaries) {
                AsyncData(:final value) =>
                  value.isEmpty
                      ? Text('No chats available')
                      : ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final chatSummary = value[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                chatSummary.chatPhoto,
                              ),
                            ),
                            title: Text(chatSummary.chatName),
                            subtitle:
                                chatSummary.lastMessage != null
                                    ? Text(
                                      chatSummary.lastMessage!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                    : const Text('No messages'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChatPage(
                                        chatId: chatSummary.chatId,
                                        chatName: chatSummary.chatName,
                                        chatPhotoUrl: chatSummary.chatPhoto,
                                        isGroup: chatSummary.isGroup,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                AsyncError() => Text('Oops! Something went wrong'),
                (_) => CircularProgressIndicator(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
