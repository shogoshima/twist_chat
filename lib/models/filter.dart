import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

/// The text filters that the backend will send to the app
@freezed
abstract class Filter with _$Filter {
  const factory Filter({
    required int id,
    required String name,
    required String emoji,
    required String command,
  }) = _Filter;

  factory Filter.fromJson(Map<String, Object?> json) =>
      _$FilterFromJson(json);
}
