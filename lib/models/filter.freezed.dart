// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Filter {

 int get id; String get name; String get emoji; String get command;
/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterCopyWith<Filter> get copyWith => _$FilterCopyWithImpl<Filter>(this as Filter, _$identity);

  /// Serializes this Filter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Filter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.command, command) || other.command == command));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,command);

@override
String toString() {
  return 'Filter(id: $id, name: $name, emoji: $emoji, command: $command)';
}


}

/// @nodoc
abstract mixin class $FilterCopyWith<$Res>  {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) _then) = _$FilterCopyWithImpl;
@useResult
$Res call({
 int id, String name, String emoji, String command
});




}
/// @nodoc
class _$FilterCopyWithImpl<$Res>
    implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._self, this._then);

  final Filter _self;
  final $Res Function(Filter) _then;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? emoji = null,Object? command = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Filter].
extension FilterPatterns on Filter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Filter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Filter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Filter value)  $default,){
final _that = this;
switch (_that) {
case _Filter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Filter value)?  $default,){
final _that = this;
switch (_that) {
case _Filter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String emoji,  String command)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Filter() when $default != null:
return $default(_that.id,_that.name,_that.emoji,_that.command);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String emoji,  String command)  $default,) {final _that = this;
switch (_that) {
case _Filter():
return $default(_that.id,_that.name,_that.emoji,_that.command);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String emoji,  String command)?  $default,) {final _that = this;
switch (_that) {
case _Filter() when $default != null:
return $default(_that.id,_that.name,_that.emoji,_that.command);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Filter implements Filter {
  const _Filter({required this.id, required this.name, required this.emoji, required this.command});
  factory _Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

@override final  int id;
@override final  String name;
@override final  String emoji;
@override final  String command;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterCopyWith<_Filter> get copyWith => __$FilterCopyWithImpl<_Filter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Filter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.command, command) || other.command == command));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,command);

@override
String toString() {
  return 'Filter(id: $id, name: $name, emoji: $emoji, command: $command)';
}


}

/// @nodoc
abstract mixin class _$FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$FilterCopyWith(_Filter value, $Res Function(_Filter) _then) = __$FilterCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String emoji, String command
});




}
/// @nodoc
class __$FilterCopyWithImpl<$Res>
    implements _$FilterCopyWith<$Res> {
  __$FilterCopyWithImpl(this._self, this._then);

  final _Filter _self;
  final $Res Function(_Filter) _then;

/// Create a copy of Filter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? emoji = null,Object? command = null,}) {
  return _then(_Filter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
