// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) =>
    _WebSocketMessage(
      id: json['id'] as String,
      text: json['text'] as String,
      senderId: json['sender_id'] as String,
      chatId: json['chat_id'] as String,
      sentAt: DateTime.parse(json['sent_at'] as String),
      textFilterId: (json['text_filter_id'] as num).toInt(),
    );

Map<String, dynamic> _$WebSocketMessageToJson(_WebSocketMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sender_id': instance.senderId,
      'chat_id': instance.chatId,
      'sent_at': instance.sentAt.toIso8601String(),
      'text_filter_id': instance.textFilterId,
    };
