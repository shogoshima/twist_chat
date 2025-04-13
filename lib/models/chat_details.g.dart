// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatDetails _$ChatDetailsFromJson(Map<String, dynamic> json) => _ChatDetails(
  chatId: json['chat_id'] as String,
  messages:
      (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
  participants:
      (json['participants'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
);

Map<String, dynamic> _$ChatDetailsToJson(_ChatDetails instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'messages': instance.messages,
      'participants': instance.participants,
      'page': instance.page,
      'page_size': instance.pageSize,
    };
