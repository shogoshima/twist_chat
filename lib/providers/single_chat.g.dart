// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$singleChatHash() => r'c03ae8ac06419d67dcc3865a24913699232149ad';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SingleChat extends BuildlessAsyncNotifier<ChatDetails> {
  late final String chatId;

  FutureOr<ChatDetails> build(String chatId);
}

/// A family provider for a granular chat state notifier, keyed by chatId.
///
/// Copied from [SingleChat].
@ProviderFor(SingleChat)
const singleChatProvider = SingleChatFamily();

/// A family provider for a granular chat state notifier, keyed by chatId.
///
/// Copied from [SingleChat].
class SingleChatFamily extends Family<AsyncValue<ChatDetails>> {
  /// A family provider for a granular chat state notifier, keyed by chatId.
  ///
  /// Copied from [SingleChat].
  const SingleChatFamily();

  /// A family provider for a granular chat state notifier, keyed by chatId.
  ///
  /// Copied from [SingleChat].
  SingleChatProvider call(String chatId) {
    return SingleChatProvider(chatId);
  }

  @override
  SingleChatProvider getProviderOverride(
    covariant SingleChatProvider provider,
  ) {
    return call(provider.chatId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleChatProvider';
}

/// A family provider for a granular chat state notifier, keyed by chatId.
///
/// Copied from [SingleChat].
class SingleChatProvider
    extends AsyncNotifierProviderImpl<SingleChat, ChatDetails> {
  /// A family provider for a granular chat state notifier, keyed by chatId.
  ///
  /// Copied from [SingleChat].
  SingleChatProvider(String chatId)
    : this._internal(
        () => SingleChat()..chatId = chatId,
        from: singleChatProvider,
        name: r'singleChatProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleChatHash,
        dependencies: SingleChatFamily._dependencies,
        allTransitiveDependencies: SingleChatFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  SingleChatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  FutureOr<ChatDetails> runNotifierBuild(covariant SingleChat notifier) {
    return notifier.build(chatId);
  }

  @override
  Override overrideWith(SingleChat Function() create) {
    return ProviderOverride(
      origin: this,
      override: SingleChatProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<SingleChat, ChatDetails> createElement() {
    return _SingleChatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleChatProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleChatRef on AsyncNotifierProviderRef<ChatDetails> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _SingleChatProviderElement
    extends AsyncNotifierProviderElement<SingleChat, ChatDetails>
    with SingleChatRef {
  _SingleChatProviderElement(super.provider);

  @override
  String get chatId => (origin as SingleChatProvider).chatId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
