// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebSocketAction _$WebSocketActionFromJson(Map<String, dynamic> json) =>
    _WebSocketAction(
      chatId: json['chat_id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$WebSocketActionToJson(_WebSocketAction instance) =>
    <String, dynamic>{'chat_id': instance.chatId, 'type': instance.type};
