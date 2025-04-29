import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twist_chat/models/models.dart';
import 'package:twist_chat/providers/api_client.dart';

part 'filter.g.dart';

@riverpod
Future<List<Filter>> filter(Ref ref) async {
  final apiClient = ref.watch(apiClientProvider);

  final json = await apiClient.get(ApiRoutes.textFilters);

  List<Filter> textFilters = [];
  if (json['textfilters'] == null) {
    return textFilters;
  }

  for (var textFilter in json['textfilters']) {
    final style = Filter.fromJson(textFilter);
    textFilters.add(style);
  }

  return textFilters;
}
