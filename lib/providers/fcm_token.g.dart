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

String _$fcmTokenHash() => r'e887d6116771dad6bea1eb02a0f51df78214b22f';
