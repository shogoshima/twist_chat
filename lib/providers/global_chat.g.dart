// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalChat)
const globalChatProvider = GlobalChatProvider._();

final class GlobalChatProvider
    extends $AsyncNotifierProvider<GlobalChat, List<ChatSummary>> {
  const GlobalChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalChatHash();

  @$internal
  @override
  GlobalChat create() => GlobalChat();
}

String _$globalChatHash() => r'1f2c900638c61558a88f63ee36203443a5239ea5';

abstract class _$GlobalChat extends $AsyncNotifier<List<ChatSummary>> {
  FutureOr<List<ChatSummary>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatSummary>>, List<ChatSummary>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatSummary>>, List<ChatSummary>>,
              AsyncValue<List<ChatSummary>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
