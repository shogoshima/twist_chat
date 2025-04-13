import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twist_chat/models/models.dart';

part 'chat_details.freezed.dart';
part 'chat_details.g.dart';

/// Model that the sqflite will save
/// This isn't for the communication with the backend
@freezed
abstract class ChatDetails with _$ChatDetails {
  const factory ChatDetails({
    required String chatId,
    required List<Message> messages,
    required List<User> participants,
    required int page,
    required int pageSize,
  }) = _ChatDetails;

  factory ChatDetails.fromJson(Map<String, Object?> json) =>
      _$ChatDetailsFromJson(json);
}
