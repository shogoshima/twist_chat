// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  username: json['username'] as String,
  photoUrl: json['photo_url'] as String,
  lastSeen:
      json['last_seen'] == null
          ? null
          : DateTime.parse(json['last_seen'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'username': instance.username,
  'photo_url': instance.photoUrl,
  'last_seen': instance.lastSeen?.toIso8601String(),
};
