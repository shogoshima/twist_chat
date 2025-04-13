import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// For the backend database
/// When the user logs in, this is the schema
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String username,
    String? photoUrl,
    DateTime? lastSeen
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
