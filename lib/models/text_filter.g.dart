// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextFilter _$TextFilterFromJson(Map<String, dynamic> json) => _TextFilter(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  emoji: json['emoji'] as String,
  command: json['command'] as String,
);

Map<String, dynamic> _$TextFilterToJson(_TextFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emoji': instance.emoji,
      'command': instance.command,
    };
