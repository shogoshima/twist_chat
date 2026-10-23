import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twist_chat/providers/api_client.dart';
import 'package:twist_chat/providers/auth.dart';
import 'package:twist_chat/providers/global_chat.dart';
import 'package:twist_chat/providers/single_chat.dart';
import 'package:twist_chat/providers/web_socket.dart';

/// Fails every token request so the socket never reaches the network, while
/// counting how many connection attempts were made.
class _FakeUser extends Fake implements User {
  int tokenRequests = 0;

  @override
  String get uid => 'me';

  @override
  Future<String?> getIdToken([bool forceRefresh = false]) async {
    tokenRequests++;
    throw StateError('offline');
  }
}

/// Serves canned responses and counts how many times each chat was fetched.
class _FakeApiClient extends ApiClient {
  final Map<String, int> chatFetches = {};

  @override
  Future<dynamic> get(String endpoint, [Map<String, dynamic>? query]) async {
    if (endpoint == ApiRoutes.summaries) {
      return {
        'chats': [
          {'chat_id': 'a', 'chat_name': 'A', 'is_group': false},
        ],
      };
    }
    final chatId = endpoint.split('/').last;
    chatFetches.update(chatId, (n) => n + 1, ifAbsent: () => 1);
    return {
      'chat': {
        'chat_id': chatId,
        'messages': [],
        'participants': [],
        'page': 1,
        'page_size': 20,
      },
    };
  }
}

void main() {
  // The socket registers an app lifecycle listener.
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeApiClient api;
  late _FakeUser user;
  late StreamController<User?> authState;
  late ProviderContainer container;

  setUp(() {
    api = _FakeApiClient();
    user = _FakeUser();
    authState = StreamController<User?>();
    container = ProviderContainer(
      overrides: [
        authStateProvider.overrideWith((ref) => authState.stream),
        apiClientProvider.overrideWith(() => api),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(authState.close);
  });

  Future<void> settle() => Future.delayed(const Duration(milliseconds: 50));

  test('refreshing the chat list keeps cached chat details', () async {
    authState.add(user);

    // Riverpod pauses providers nobody listens to; subscribe like the UI does.
    container.listen(globalChatProvider, (_, _) {});
    container.listen(singleChatProvider('a'), (_, _) {});
    await container.read(globalChatProvider.future);
    await container.read(singleChatProvider('a').future);

    // What a `refresh_summary` action from the socket does.
    container.invalidate(globalChatProvider);
    await container.read(globalChatProvider.future);
    await container.read(singleChatProvider('a').future);

    expect(api.chatFetches['a'], 1);
  });

  test('the socket connects again after logging out and back in', () async {
    container.listen(webSocketProvider, (_, _) {});

    authState.add(user);
    await settle();
    expect(user.tokenRequests, 1);

    authState.add(null);
    await settle();
    authState.add(user);
    await settle();

    expect(user.tokenRequests, 2);
  });
}
