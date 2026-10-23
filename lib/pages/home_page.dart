import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/pages/account_page.dart';
import 'package:twist_chat/pages/chats_page.dart';
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/fcm_token.dart';
import 'package:twist_chat/providers/filter.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/open_chat.dart';
import 'package:twist_chat/providers/unread_chats.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/disappearing_bottom_navigation_bar.dart';
import 'package:twist_chat/widgets/disappearing_navigation_rail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _titles = ['Chats', 'Settings'];

  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  late final StreamSubscription<RemoteMessage> _foregroundMessages;

  @override
  void initState() {
    super.initState();
    _foregroundMessages = FirebaseMessaging.onMessage.listen((message) {
      if (message.data.isEmpty) return;
      final openChatId = ref.read(openChatProvider);
      if (openChatId == null || openChatId != message.data['chat_id']) {
        ref.read(unreadChatsProvider.notifier).handleIncomingMessage(message);
      }
    });
  }

  void _onDestinationSelected(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPageIndex = index;
    });
  }

  // When the user swipes, update the selected index
  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void dispose() {
    _foregroundMessages.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keep the session providers alive while signed in. Listening instead of
    // watching avoids rebuilding this page whenever one changes (the chat
    // list does on every incoming message).
    ref.listen(openChatProvider, (_, _) {});
    ref.listen(filterProvider, (_, _) {});
    ref.listen(activeFilterProvider, (_, _) {});
    ref.listen(fcmTokenProvider, (_, _) {});
    ref.listen(unreadChatsProvider, (_, _) {});
    ref.listen(globalChatProvider, (_, _) {});

    // sizeOf only depends on the size, so keyboard insets animating (e.g.
    // while typing in a chat pushed on top) don't rebuild this page.
    final wideScreen = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(_titles[_currentPageIndex]),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: _ConnectionStatus(),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (wideScreen)
            DisappearingNavigationRail(
              selectedIndex: _currentPageIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              children: const [ChatsPage(), AccountPage()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: wideScreen
          ? null
          : DisappearingBottomNavigationBar(
              selectedIndex: _currentPageIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
    );
  }
}

/// Whether the real-time connection is up.
class _ConnectionStatus extends ConsumerWidget {
  const _ConnectionStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (Widget indicator, String label) = switch (ref.watch(
      webSocketProvider,
    )) {
      AsyncData(value: _?) => (const _Dot(color: Colors.green), 'Online'),
      AsyncData() => (const _Dot(color: Colors.red), 'Offline'),
      AsyncError() => (
        const Icon(Icons.error, color: Colors.red, size: 16),
        'Error',
      ),
      _ => (
        const SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        'Connecting...',
      ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    // Animates the color when the connection status flips.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
