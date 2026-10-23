// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filter)
const filterProvider = FilterProvider._();

final class FilterProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Filter>>,
          List<Filter>,
          FutureOr<List<Filter>>
        >
    with $FutureModifier<List<Filter>>, $FutureProvider<List<Filter>> {
  const FilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterHash();

  @$internal
  @override
  $FutureProviderElement<List<Filter>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Filter>> create(Ref ref) {
    return filter(ref);
  }
}

String _$filterHash() => r'9508d9bd65e273ffed0bb0f27ed98757fd79eae0';
