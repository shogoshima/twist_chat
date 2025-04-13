import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_socket_message.freezed.dart';
part 'web_socket_message.g.dart';

/// For the communication with the backend websocket
@freezed
abstract class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String id,
    required String text,
    required String senderId,
    required String chatId,
    required DateTime sentAt,
    required int textFilterId,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, Object?> json) =>
      _$WebSocketMessageFromJson(json);
}
