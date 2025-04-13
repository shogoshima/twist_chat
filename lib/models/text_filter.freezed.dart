// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextFilter {

 int get id; String get name; String get emoji; String get command;
/// Create a copy of TextFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextFilterCopyWith<TextFilter> get copyWith => _$TextFilterCopyWithImpl<TextFilter>(this as TextFilter, _$identity);

  /// Serializes this TextFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.command, command) || other.command == command));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,command);

@override
String toString() {
  return 'TextFilter(id: $id, name: $name, emoji: $emoji, command: $command)';
}


}

/// @nodoc
abstract mixin class $TextFilterCopyWith<$Res>  {
  factory $TextFilterCopyWith(TextFilter value, $Res Function(TextFilter) _then) = _$TextFilterCopyWithImpl;
@useResult
$Res call({
 int id, String name, String emoji, String command
});




}
/// @nodoc
class _$TextFilterCopyWithImpl<$Res>
    implements $TextFilterCopyWith<$Res> {
  _$TextFilterCopyWithImpl(this._self, this._then);

  final TextFilter _self;
  final $Res Function(TextFilter) _then;

/// Create a copy of TextFilter
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


/// @nodoc
@JsonSerializable()

class _TextFilter implements TextFilter {
  const _TextFilter({required this.id, required this.name, required this.emoji, required this.command});
  factory _TextFilter.fromJson(Map<String, dynamic> json) => _$TextFilterFromJson(json);

@override final  int id;
@override final  String name;
@override final  String emoji;
@override final  String command;

/// Create a copy of TextFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextFilterCopyWith<_TextFilter> get copyWith => __$TextFilterCopyWithImpl<_TextFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.command, command) || other.command == command));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,command);

@override
String toString() {
  return 'TextFilter(id: $id, name: $name, emoji: $emoji, command: $command)';
}


}

/// @nodoc
abstract mixin class _$TextFilterCopyWith<$Res> implements $TextFilterCopyWith<$Res> {
  factory _$TextFilterCopyWith(_TextFilter value, $Res Function(_TextFilter) _then) = __$TextFilterCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String emoji, String command
});




}
/// @nodoc
class __$TextFilterCopyWithImpl<$Res>
    implements _$TextFilterCopyWith<$Res> {
  __$TextFilterCopyWithImpl(this._self, this._then);

  final _TextFilter _self;
  final $Res Function(_TextFilter) _then;

/// Create a copy of TextFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? emoji = null,Object? command = null,}) {
  return _then(_TextFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
