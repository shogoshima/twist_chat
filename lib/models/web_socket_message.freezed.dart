// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_socket_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketMessage {

 String get id; String get text; String get senderId; String get chatId; DateTime get sentAt; int get textFilterId;
/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSocketMessageCopyWith<WebSocketMessage> get copyWith => _$WebSocketMessageCopyWithImpl<WebSocketMessage>(this as WebSocketMessage, _$identity);

  /// Serializes this WebSocketMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSocketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.textFilterId, textFilterId) || other.textFilterId == textFilterId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,senderId,chatId,sentAt,textFilterId);

@override
String toString() {
  return 'WebSocketMessage(id: $id, text: $text, senderId: $senderId, chatId: $chatId, sentAt: $sentAt, textFilterId: $textFilterId)';
}


}

/// @nodoc
abstract mixin class $WebSocketMessageCopyWith<$Res>  {
  factory $WebSocketMessageCopyWith(WebSocketMessage value, $Res Function(WebSocketMessage) _then) = _$WebSocketMessageCopyWithImpl;
@useResult
$Res call({
 String id, String text, String senderId, String chatId, DateTime sentAt, int textFilterId
});




}
/// @nodoc
class _$WebSocketMessageCopyWithImpl<$Res>
    implements $WebSocketMessageCopyWith<$Res> {
  _$WebSocketMessageCopyWithImpl(this._self, this._then);

  final WebSocketMessage _self;
  final $Res Function(WebSocketMessage) _then;

/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? senderId = null,Object? chatId = null,Object? sentAt = null,Object? textFilterId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,textFilterId: null == textFilterId ? _self.textFilterId : textFilterId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WebSocketMessage implements WebSocketMessage {
  const _WebSocketMessage({required this.id, required this.text, required this.senderId, required this.chatId, required this.sentAt, required this.textFilterId});
  factory _WebSocketMessage.fromJson(Map<String, dynamic> json) => _$WebSocketMessageFromJson(json);

@override final  String id;
@override final  String text;
@override final  String senderId;
@override final  String chatId;
@override final  DateTime sentAt;
@override final  int textFilterId;

/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebSocketMessageCopyWith<_WebSocketMessage> get copyWith => __$WebSocketMessageCopyWithImpl<_WebSocketMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebSocketMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSocketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.textFilterId, textFilterId) || other.textFilterId == textFilterId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,senderId,chatId,sentAt,textFilterId);

@override
String toString() {
  return 'WebSocketMessage(id: $id, text: $text, senderId: $senderId, chatId: $chatId, sentAt: $sentAt, textFilterId: $textFilterId)';
}


}

/// @nodoc
abstract mixin class _$WebSocketMessageCopyWith<$Res> implements $WebSocketMessageCopyWith<$Res> {
  factory _$WebSocketMessageCopyWith(_WebSocketMessage value, $Res Function(_WebSocketMessage) _then) = __$WebSocketMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String senderId, String chatId, DateTime sentAt, int textFilterId
});




}
/// @nodoc
class __$WebSocketMessageCopyWithImpl<$Res>
    implements _$WebSocketMessageCopyWith<$Res> {
  __$WebSocketMessageCopyWithImpl(this._self, this._then);

  final _WebSocketMessage _self;
  final $Res Function(_WebSocketMessage) _then;

/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? senderId = null,Object? chatId = null,Object? sentAt = null,Object? textFilterId = null,}) {
  return _then(_WebSocketMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,textFilterId: null == textFilterId ? _self.textFilterId : textFilterId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
