// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchUserHash() => r'0b4d18bea43987725c3992d353ae45232903c1b6';

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

abstract class _$SearchUser extends BuildlessAutoDisposeAsyncNotifier<User?> {
  late final String username;

  FutureOr<User?> build(String username);
}

/// See also [SearchUser].
@ProviderFor(SearchUser)
const searchUserProvider = SearchUserFamily();

/// See also [SearchUser].
class SearchUserFamily extends Family<AsyncValue<User?>> {
  /// See also [SearchUser].
  const SearchUserFamily();

  /// See also [SearchUser].
  SearchUserProvider call(String username) {
    return SearchUserProvider(username);
  }

  @override
  SearchUserProvider getProviderOverride(
    covariant SearchUserProvider provider,
  ) {
    return call(provider.username);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchUserProvider';
}

/// See also [SearchUser].
class SearchUserProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchUser, User?> {
  /// See also [SearchUser].
  SearchUserProvider(String username)
    : this._internal(
        () => SearchUser()..username = username,
        from: searchUserProvider,
        name: r'searchUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchUserHash,
        dependencies: SearchUserFamily._dependencies,
        allTransitiveDependencies: SearchUserFamily._allTransitiveDependencies,
        username: username,
      );

  SearchUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  FutureOr<User?> runNotifierBuild(covariant SearchUser notifier) {
    return notifier.build(username);
  }

  @override
  Override overrideWith(SearchUser Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchUserProvider._internal(
        () => create()..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchUser, User?> createElement() {
    return _SearchUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchUserProvider && other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchUserRef on AutoDisposeAsyncNotifierProviderRef<User?> {
  /// The parameter `username` of this provider.
  String get username;
}

class _SearchUserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchUser, User?>
    with SearchUserRef {
  _SearchUserProviderElement(super.provider);

  @override
  String get username => (origin as SearchUserProvider).username;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
