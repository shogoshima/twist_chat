import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// For the backend database
/// The messages that will be loaded are in this format
@freezed
abstract class Message with _$Message {
  const factory Message({
    required String id,
    required String chatId,
    required String senderId,
    required String text,
    required DateTime sentAt,
    bool? seen,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
