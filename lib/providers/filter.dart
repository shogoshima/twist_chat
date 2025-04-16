import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';
import 'package:twist_chat/providers/google_auth.dart';

part 'filter.g.dart';

@riverpod
Future<List<TextFilter>> filter(Ref ref) async {
  final apiClient = ref.watch(apiClientProvider);
  ref.watch(googleAuthProvider);

  final hasToken = await apiClient.hasToken();
  if (!hasToken) return [];

  final json = await apiClient.get(ApiRoutes.textFilters);

  List<TextFilter> textFilters = [];
  if (json['textfilters'] == null) {
    return textFilters;
  }

  for (var textFilter in json['textfilters']) {
    final style = TextFilter.fromJson(textFilter);
    textFilters.add(style);
  }

  return textFilters;
}
