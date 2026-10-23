// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_chats.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ids of the chats with messages the user hasn't seen, persisted across
/// launches.

@ProviderFor(UnreadChats)
const unreadChatsProvider = UnreadChatsProvider._();

/// Ids of the chats with messages the user hasn't seen, persisted across
/// launches.
final class UnreadChatsProvider
    extends $AsyncNotifierProvider<UnreadChats, Set<String>> {
  /// Ids of the chats with messages the user hasn't seen, persisted across
  /// launches.
  const UnreadChatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadChatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadChatsHash();

  @$internal
  @override
  UnreadChats create() => UnreadChats();
}

String _$unreadChatsHash() => r'4159f53ed8f350770c3cf39b5ee524197f4a0df1';

/// Ids of the chats with messages the user hasn't seen, persisted across
/// launches.

abstract class _$UnreadChats extends $AsyncNotifier<Set<String>> {
  FutureOr<Set<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Set<String>>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<String>>, Set<String>>,
              AsyncValue<Set<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
