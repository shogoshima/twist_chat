import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twist_chat/models/models.dart';

part 'chat_details.freezed.dart';
part 'chat_details.g.dart';

/// A chat's participants and one page of its messages, newest first.
@freezed
abstract class ChatDetails with _$ChatDetails {
  const factory ChatDetails({
    required String chatId,
    required List<Message> messages,
    required List<Profile> participants,
    required int page,
    required int pageSize,
  }) = _ChatDetails;

  factory ChatDetails.fromJson(Map<String, Object?> json) =>
      _$ChatDetailsFromJson(json);
}
