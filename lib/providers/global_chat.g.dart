// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Session-wide chat list: kept alive for the whole session and rebuilt
/// whenever the signed-in user changes.

@ProviderFor(GlobalChat)
const globalChatProvider = GlobalChatProvider._();

/// Session-wide chat list: kept alive for the whole session and rebuilt
/// whenever the signed-in user changes.
final class GlobalChatProvider
    extends $AsyncNotifierProvider<GlobalChat, List<ChatSummary>> {
  /// Session-wide chat list: kept alive for the whole session and rebuilt
  /// whenever the signed-in user changes.
  const GlobalChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalChatProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalChatHash();

  @$internal
  @override
  GlobalChat create() => GlobalChat();
}

String _$globalChatHash() => r'9623fd2044ae4fef919b717730324822b25c3a90';

/// Session-wide chat list: kept alive for the whole session and rebuilt
/// whenever the signed-in user changes.

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
