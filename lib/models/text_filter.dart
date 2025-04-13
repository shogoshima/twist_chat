import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_filter.freezed.dart';
part 'text_filter.g.dart';

/// The text filters that the backend will send to the app
@freezed
abstract class TextFilter with _$TextFilter {
  const factory TextFilter({
    required int id,
    required String name,
    required String emoji,
    required String command,
  }) = _TextFilter;

  factory TextFilter.fromJson(Map<String, Object?> json) =>
      _$TextFilterFromJson(json);
}
