// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Filter _$FilterFromJson(Map<String, dynamic> json) => _Filter(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  emoji: json['emoji'] as String,
  command: json['command'] as String,
);

Map<String, dynamic> _$FilterToJson(_Filter instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'emoji': instance.emoji,
  'command': instance.command,
};
