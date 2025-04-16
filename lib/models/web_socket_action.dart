import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_socket_action.freezed.dart';
part 'web_socket_action.g.dart';

/// For the communication with the backend websocket
@freezed
abstract class WebSocketAction with _$WebSocketAction {
  const factory WebSocketAction({
    required String chatId,
    required String type,
  }) = _WebSocketAction;

  factory WebSocketAction.fromJson(Map<String, Object?> json) =>
      _$WebSocketActionFromJson(json);
}
