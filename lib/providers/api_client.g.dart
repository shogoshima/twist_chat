// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApiClient)
const apiClientProvider = ApiClientProvider._();

final class ApiClientProvider extends $NotifierProvider<ApiClient, ApiClient> {
  const ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  ApiClient create() => ApiClient();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'c8ae956de1eb19720440c128cf143ac7f39f3e73';

abstract class _$ApiClient extends $Notifier<ApiClient> {
  ApiClient build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ApiClient, ApiClient>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ApiClient, ApiClient>,
              ApiClient,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
