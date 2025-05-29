import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_chat.g.dart';

@riverpod
class OpenChat extends _$OpenChat {
  @override
  String? build() {
    return null;
  }

  void open(String chatId) {
    state = chatId;
  }

  void close() {
    state = null;
  }
}
