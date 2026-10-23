// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatSummary {

 String get chatId; String get chatName; bool get isGroup; String? get chatPhoto; String? get lastMessage;
/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSummaryCopyWith<ChatSummary> get copyWith => _$ChatSummaryCopyWithImpl<ChatSummary>(this as ChatSummary, _$identity);

  /// Serializes this ChatSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSummary&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.chatName, chatName) || other.chatName == chatName)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.chatPhoto, chatPhoto) || other.chatPhoto == chatPhoto)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,chatName,isGroup,chatPhoto,lastMessage);

@override
String toString() {
  return 'ChatSummary(chatId: $chatId, chatName: $chatName, isGroup: $isGroup, chatPhoto: $chatPhoto, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ChatSummaryCopyWith<$Res>  {
  factory $ChatSummaryCopyWith(ChatSummary value, $Res Function(ChatSummary) _then) = _$ChatSummaryCopyWithImpl;
@useResult
$Res call({
 String chatId, String chatName, bool isGroup, String? chatPhoto, String? lastMessage
});




}
/// @nodoc
class _$ChatSummaryCopyWithImpl<$Res>
    implements $ChatSummaryCopyWith<$Res> {
  _$ChatSummaryCopyWithImpl(this._self, this._then);

  final ChatSummary _self;
  final $Res Function(ChatSummary) _then;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? chatName = null,Object? isGroup = null,Object? chatPhoto = freezed,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,chatName: null == chatName ? _self.chatName : chatName // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,chatPhoto: freezed == chatPhoto ? _self.chatPhoto : chatPhoto // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSummary].
extension ChatSummaryPatterns on ChatSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSummary value)  $default,){
final _that = this;
switch (_that) {
case _ChatSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chatId,  String chatName,  bool isGroup,  String? chatPhoto,  String? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
return $default(_that.chatId,_that.chatName,_that.isGroup,_that.chatPhoto,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chatId,  String chatName,  bool isGroup,  String? chatPhoto,  String? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatSummary():
return $default(_that.chatId,_that.chatName,_that.isGroup,_that.chatPhoto,_that.lastMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chatId,  String chatName,  bool isGroup,  String? chatPhoto,  String? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatSummary() when $default != null:
return $default(_that.chatId,_that.chatName,_that.isGroup,_that.chatPhoto,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatSummary implements ChatSummary {
  const _ChatSummary({required this.chatId, required this.chatName, required this.isGroup, this.chatPhoto, this.lastMessage});
  factory _ChatSummary.fromJson(Map<String, dynamic> json) => _$ChatSummaryFromJson(json);

@override final  String chatId;
@override final  String chatName;
@override final  bool isGroup;
@override final  String? chatPhoto;
@override final  String? lastMessage;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSummaryCopyWith<_ChatSummary> get copyWith => __$ChatSummaryCopyWithImpl<_ChatSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSummary&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.chatName, chatName) || other.chatName == chatName)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.chatPhoto, chatPhoto) || other.chatPhoto == chatPhoto)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,chatName,isGroup,chatPhoto,lastMessage);

@override
String toString() {
  return 'ChatSummary(chatId: $chatId, chatName: $chatName, isGroup: $isGroup, chatPhoto: $chatPhoto, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatSummaryCopyWith<$Res> implements $ChatSummaryCopyWith<$Res> {
  factory _$ChatSummaryCopyWith(_ChatSummary value, $Res Function(_ChatSummary) _then) = __$ChatSummaryCopyWithImpl;
@override @useResult
$Res call({
 String chatId, String chatName, bool isGroup, String? chatPhoto, String? lastMessage
});




}
/// @nodoc
class __$ChatSummaryCopyWithImpl<$Res>
    implements _$ChatSummaryCopyWith<$Res> {
  __$ChatSummaryCopyWithImpl(this._self, this._then);

  final _ChatSummary _self;
  final $Res Function(_ChatSummary) _then;

/// Create a copy of ChatSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? chatName = null,Object? isGroup = null,Object? chatPhoto = freezed,Object? lastMessage = freezed,}) {
  return _then(_ChatSummary(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,chatName: null == chatName ? _self.chatName : chatName // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,chatPhoto: freezed == chatPhoto ? _self.chatPhoto : chatPhoto // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
