import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_socket_authentication.freezed.dart';
part 'web_socket_authentication.g.dart';

/// For the communication with the backend websocket
@freezed
abstract class WebSocketAuthentication with _$WebSocketAuthentication {
  const factory WebSocketAuthentication({required String idToken}) =
      _WebSocketAuthentication;

  factory WebSocketAuthentication.fromJson(Map<String, Object?> json) =>
      _$WebSocketAuthenticationFromJson(json);
}
