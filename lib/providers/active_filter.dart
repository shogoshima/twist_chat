import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_filter.g.dart';

@riverpod
class ActiveFilter extends _$ActiveFilter {
  @override
  int build() {
    return 0;
  }

  void setActiveTextFilter(int option) {
    state = option;
  }
}
