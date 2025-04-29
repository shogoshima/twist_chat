// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatDetails {

 String get chatId; List<Message> get messages; List<Profile> get participants; int get page; int get pageSize;
/// Create a copy of ChatDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDetailsCopyWith<ChatDetails> get copyWith => _$ChatDetailsCopyWithImpl<ChatDetails>(this as ChatDetails, _$identity);

  /// Serializes this ChatDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetails&&(identical(other.chatId, chatId) || other.chatId == chatId)&&const DeepCollectionEquality().equals(other.messages, messages)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,const DeepCollectionEquality().hash(messages),const DeepCollectionEquality().hash(participants),page,pageSize);

@override
String toString() {
  return 'ChatDetails(chatId: $chatId, messages: $messages, participants: $participants, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ChatDetailsCopyWith<$Res>  {
  factory $ChatDetailsCopyWith(ChatDetails value, $Res Function(ChatDetails) _then) = _$ChatDetailsCopyWithImpl;
@useResult
$Res call({
 String chatId, List<Message> messages, List<Profile> participants, int page, int pageSize
});




}
/// @nodoc
class _$ChatDetailsCopyWithImpl<$Res>
    implements $ChatDetailsCopyWith<$Res> {
  _$ChatDetailsCopyWithImpl(this._self, this._then);

  final ChatDetails _self;
  final $Res Function(ChatDetails) _then;

/// Create a copy of ChatDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? messages = null,Object? participants = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Profile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChatDetails implements ChatDetails {
  const _ChatDetails({required this.chatId, required final  List<Message> messages, required final  List<Profile> participants, required this.page, required this.pageSize}): _messages = messages,_participants = participants;
  factory _ChatDetails.fromJson(Map<String, dynamic> json) => _$ChatDetailsFromJson(json);

@override final  String chatId;
 final  List<Message> _messages;
@override List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  List<Profile> _participants;
@override List<Profile> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  int page;
@override final  int pageSize;

/// Create a copy of ChatDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatDetailsCopyWith<_ChatDetails> get copyWith => __$ChatDetailsCopyWithImpl<_ChatDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatDetails&&(identical(other.chatId, chatId) || other.chatId == chatId)&&const DeepCollectionEquality().equals(other._messages, _messages)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_participants),page,pageSize);

@override
String toString() {
  return 'ChatDetails(chatId: $chatId, messages: $messages, participants: $participants, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$ChatDetailsCopyWith<$Res> implements $ChatDetailsCopyWith<$Res> {
  factory _$ChatDetailsCopyWith(_ChatDetails value, $Res Function(_ChatDetails) _then) = __$ChatDetailsCopyWithImpl;
@override @useResult
$Res call({
 String chatId, List<Message> messages, List<Profile> participants, int page, int pageSize
});




}
/// @nodoc
class __$ChatDetailsCopyWithImpl<$Res>
    implements _$ChatDetailsCopyWith<$Res> {
  __$ChatDetailsCopyWithImpl(this._self, this._then);

  final _ChatDetails _self;
  final $Res Function(_ChatDetails) _then;

/// Create a copy of ChatDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? messages = null,Object? participants = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_ChatDetails(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Profile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
