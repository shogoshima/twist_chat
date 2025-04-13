import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_summary.freezed.dart';
part 'chat_summary.g.dart';

/// Model that the sqflite will save
/// This isn't for the communication with the backend
@freezed
abstract class ChatSummary with _$ChatSummary {
  const factory ChatSummary({
    required String chatId,
    required String chatName,
    required bool isGroup,
    required String chatPhoto,
    String? lastMessage,
  }) = _ChatSummary;

  factory ChatSummary.fromJson(Map<String, Object?> json) =>
      _$ChatSummaryFromJson(json);
}
