// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  username: json['username'] as String,
  photoUrl: json['photo_url'] as String,
  lastSeen:
      json['last_seen'] == null
          ? null
          : DateTime.parse(json['last_seen'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'photo_url': instance.photoUrl,
  'last_seen': instance.lastSeen?.toIso8601String(),
};
