// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A family provider for a granular chat state notifier, keyed by chatId.

@ProviderFor(SingleChat)
const singleChatProvider = SingleChatFamily._();

/// A family provider for a granular chat state notifier, keyed by chatId.
final class SingleChatProvider
    extends $AsyncNotifierProvider<SingleChat, ChatDetails> {
  /// A family provider for a granular chat state notifier, keyed by chatId.
  const SingleChatProvider._({
    required SingleChatFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'singleChatProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$singleChatHash();

  @override
  String toString() {
    return r'singleChatProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SingleChat create() => SingleChat();

  @override
  bool operator ==(Object other) {
    return other is SingleChatProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$singleChatHash() => r'3209318a009cd22f7a0e71f8d34df67bf88cc372';

/// A family provider for a granular chat state notifier, keyed by chatId.

final class SingleChatFamily extends $Family
    with
        $ClassFamilyOverride<
          SingleChat,
          AsyncValue<ChatDetails>,
          ChatDetails,
          FutureOr<ChatDetails>,
          String
        > {
  const SingleChatFamily._()
    : super(
        retry: null,
        name: r'singleChatProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A family provider for a granular chat state notifier, keyed by chatId.

  SingleChatProvider call(String chatId) =>
      SingleChatProvider._(argument: chatId, from: this);

  @override
  String toString() => r'singleChatProvider';
}

/// A family provider for a granular chat state notifier, keyed by chatId.

abstract class _$SingleChat extends $AsyncNotifier<ChatDetails> {
  late final _$args = ref.$arg as String;
  String get chatId => _$args;

  FutureOr<ChatDetails> build(String chatId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ChatDetails>, ChatDetails>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatDetails>, ChatDetails>,
              AsyncValue<ChatDetails>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
