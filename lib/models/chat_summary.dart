import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_summary.freezed.dart';
part 'chat_summary.g.dart';

/// A chat as listed on the chats page, without its messages.
@freezed
abstract class ChatSummary with _$ChatSummary {
  const factory ChatSummary({
    required String chatId,
    required String chatName,
    required bool isGroup,
    String? chatPhoto,
    String? lastMessage,
  }) = _ChatSummary;

  factory ChatSummary.fromJson(Map<String, Object?> json) =>
      _$ChatSummaryFromJson(json);
}
