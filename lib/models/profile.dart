import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// For the backend database
/// When the user logs in, this is the schema
@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String displayName,
    required String username,
    required String photoUrl,
    DateTime? lastSeen
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) => _$ProfileFromJson(json);
}
