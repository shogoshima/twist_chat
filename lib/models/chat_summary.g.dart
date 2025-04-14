// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatSummary _$ChatSummaryFromJson(Map<String, dynamic> json) => _ChatSummary(
  chatId: json['chat_id'] as String,
  chatName: json['chat_name'] as String,
  isGroup: json['is_group'] as bool,
  chatPhoto: json['chat_photo'] as String?,
  lastMessage: json['last_message'] as String?,
);

Map<String, dynamic> _$ChatSummaryToJson(_ChatSummary instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'chat_name': instance.chatName,
      'is_group': instance.isGroup,
      'chat_photo': instance.chatPhoto,
      'last_message': instance.lastMessage,
    };
