// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [WebSocketMessage].
extension WebSocketMessagePatterns on WebSocketMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebSocketMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebSocketMessage value)  $default,){
final _that = this;
switch (_that) {
case _WebSocketMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebSocketMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String senderId,  String chatId,  DateTime sentAt,  int textFilterId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that.id,_that.text,_that.senderId,_that.chatId,_that.sentAt,_that.textFilterId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String senderId,  String chatId,  DateTime sentAt,  int textFilterId)  $default,) {final _that = this;
switch (_that) {
case _WebSocketMessage():
return $default(_that.id,_that.text,_that.senderId,_that.chatId,_that.sentAt,_that.textFilterId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String senderId,  String chatId,  DateTime sentAt,  int textFilterId)?  $default,) {final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that.id,_that.text,_that.senderId,_that.chatId,_that.sentAt,_that.textFilterId);case _:
  return null;

}
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
