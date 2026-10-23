// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OpenChat)
const openChatProvider = OpenChatProvider._();

final class OpenChatProvider extends $NotifierProvider<OpenChat, String?> {
  const OpenChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openChatHash();

  @$internal
  @override
  OpenChat create() => OpenChat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$openChatHash() => r'348a57a5736847acacbcc2c0940575a33fa5f3ec';

abstract class _$OpenChat extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
