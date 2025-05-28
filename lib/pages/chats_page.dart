import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/pages/chat_page.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/widgets/show_create_chat_modal.dart';
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
    return Scaffold(
      body: Column(
        children: [
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
                            leading:
                                chatSummary.chatPhoto != null
                                    ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        chatSummary.chatPhoto!,
                                      ),
                                    )
                                    : CircleAvatar(
                                      backgroundColor: Colors.black,
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
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ChatPage(chatId: chatSummary.chatId),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCreateChatModal(context, ref);
        },
        icon: Icon(Icons.add),
        label: Text('New chat'),
      ),
    );
  }
}
