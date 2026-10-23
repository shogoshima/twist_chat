// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_socket_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketAction {

 String get chatId; String get type;
/// Create a copy of WebSocketAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSocketActionCopyWith<WebSocketAction> get copyWith => _$WebSocketActionCopyWithImpl<WebSocketAction>(this as WebSocketAction, _$identity);

  /// Serializes this WebSocketAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSocketAction&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,type);

@override
String toString() {
  return 'WebSocketAction(chatId: $chatId, type: $type)';
}


}

/// @nodoc
abstract mixin class $WebSocketActionCopyWith<$Res>  {
  factory $WebSocketActionCopyWith(WebSocketAction value, $Res Function(WebSocketAction) _then) = _$WebSocketActionCopyWithImpl;
@useResult
$Res call({
 String chatId, String type
});




}
/// @nodoc
class _$WebSocketActionCopyWithImpl<$Res>
    implements $WebSocketActionCopyWith<$Res> {
  _$WebSocketActionCopyWithImpl(this._self, this._then);

  final WebSocketAction _self;
  final $Res Function(WebSocketAction) _then;

/// Create a copy of WebSocketAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? type = null,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WebSocketAction].
extension WebSocketActionPatterns on WebSocketAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebSocketAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebSocketAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebSocketAction value)  $default,){
final _that = this;
switch (_that) {
case _WebSocketAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebSocketAction value)?  $default,){
final _that = this;
switch (_that) {
case _WebSocketAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chatId,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebSocketAction() when $default != null:
return $default(_that.chatId,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chatId,  String type)  $default,) {final _that = this;
switch (_that) {
case _WebSocketAction():
return $default(_that.chatId,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chatId,  String type)?  $default,) {final _that = this;
switch (_that) {
case _WebSocketAction() when $default != null:
return $default(_that.chatId,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebSocketAction implements WebSocketAction {
  const _WebSocketAction({required this.chatId, required this.type});
  factory _WebSocketAction.fromJson(Map<String, dynamic> json) => _$WebSocketActionFromJson(json);

@override final  String chatId;
@override final  String type;

/// Create a copy of WebSocketAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebSocketActionCopyWith<_WebSocketAction> get copyWith => __$WebSocketActionCopyWithImpl<_WebSocketAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebSocketActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSocketAction&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,type);

@override
String toString() {
  return 'WebSocketAction(chatId: $chatId, type: $type)';
}


}

/// @nodoc
abstract mixin class _$WebSocketActionCopyWith<$Res> implements $WebSocketActionCopyWith<$Res> {
  factory _$WebSocketActionCopyWith(_WebSocketAction value, $Res Function(_WebSocketAction) _then) = __$WebSocketActionCopyWithImpl;
@override @useResult
$Res call({
 String chatId, String type
});




}
/// @nodoc
class __$WebSocketActionCopyWithImpl<$Res>
    implements _$WebSocketActionCopyWith<$Res> {
  __$WebSocketActionCopyWithImpl(this._self, this._then);

  final _WebSocketAction _self;
  final $Res Function(_WebSocketAction) _then;

/// Create a copy of WebSocketAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? type = null,}) {
  return _then(_WebSocketAction(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
