// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveFilter)
const activeFilterProvider = ActiveFilterProvider._();

final class ActiveFilterProvider extends $NotifierProvider<ActiveFilter, int> {
  const ActiveFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeFilterHash();

  @$internal
  @override
  ActiveFilter create() => ActiveFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$activeFilterHash() => r'bfaf7236070e2f69b21eb76ab37fa47a6f3f2305';

abstract class _$ActiveFilter extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
