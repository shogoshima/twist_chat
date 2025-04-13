// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  chatId: json['chat_id'] as String,
  senderId: json['sender_id'] as String,
  text: json['text'] as String,
  sentAt: DateTime.parse(json['sent_at'] as String),
  seen: json['seen'] as bool?,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'chat_id': instance.chatId,
  'sender_id': instance.senderId,
  'text': instance.text,
  'sent_at': instance.sentAt.toIso8601String(),
  'seen': instance.seen,
};
