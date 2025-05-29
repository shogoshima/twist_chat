import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/pages/account_page.dart';
import 'package:twist_chat/pages/chats_page.dart';
import 'package:twist_chat/providers/active_filter.dart';
import 'package:twist_chat/providers/fcm_token.dart';
import 'package:twist_chat/providers/filter.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/notification.dart';
import 'package:twist_chat/providers/open_chat.dart';
import 'package:twist_chat/providers/web_socket.dart';
import 'package:twist_chat/widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final List<String> _titles = ['Chats', 'Settings'];

  bool wideScreen = false;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data.isEmpty) return;
      final openChatId = ref.watch(openChatProvider);
      if (openChatId == null || openChatId != message.data['chat_id']) {
        ref.read(notificationProvider.notifier).handleIncomingMessage(message);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(globalChatProvider);
    ref.watch(filterProvider);
    ref.watch(activeFilterProvider);
    ref.watch(fcmTokenProvider);
    ref.watch(notificationProvider);
    ref.watch(openChatProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(_titles[_currentPageIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final webSocketState = ref.watch(webSocketProvider);
                    return webSocketState.when(
                      data: (channel) {
                        if (channel != null) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // A small animated green dot.
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "Online",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // A red dot for a null channel (disconnected).
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "Offline",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          );
                        }
                      },
                      loading:
                          () => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Connecting...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                      error:
                          (error, stack) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.error, color: Colors.red, size: 16),
                              SizedBox(width: 5),
                              Text("Error", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (wideScreen) // Mostrando a barra lateral condicionalmente
            DisappearingNavigationRail(
              selectedIndex: _currentPageIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
          Expanded(
            // Directly use the PageView to manage the pages.
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              children: const [ChatsPage(), AccountPage()],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          wideScreen // Mostrando a barra inferior condicionalmente
              ? null
              : DisappearingBottomNavigationBar(
                selectedIndex: _currentPageIndex,
                onDestinationSelected: _onDestinationSelected,
              ),
    );
  }
}
