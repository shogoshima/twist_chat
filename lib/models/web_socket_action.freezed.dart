// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
