// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fcmToken)
const fcmTokenProvider = FcmTokenProvider._();

final class FcmTokenProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const FcmTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmTokenHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return fcmToken(ref);
  }
}

String _$fcmTokenHash() => r'26c0402b722228a3d70c6a3121856823b61723e6';
