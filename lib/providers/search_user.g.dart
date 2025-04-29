// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchUserHash() => r'e0a7fc651c03c8e35958adc38c5fcfbe3c420ed6';

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

/// See also [searchUser].
@ProviderFor(searchUser)
const searchUserProvider = SearchUserFamily();

/// See also [searchUser].
class SearchUserFamily extends Family<AsyncValue<Profile?>> {
  /// See also [searchUser].
  const SearchUserFamily();

  /// See also [searchUser].
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

/// See also [searchUser].
class SearchUserProvider extends AutoDisposeFutureProvider<Profile?> {
  /// See also [searchUser].
  SearchUserProvider(String username)
    : this._internal(
        (ref) => searchUser(ref as SearchUserRef, username),
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
  Override overrideWith(
    FutureOr<Profile?> Function(SearchUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchUserProvider._internal(
        (ref) => create(ref as SearchUserRef),
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
  AutoDisposeFutureProviderElement<Profile?> createElement() {
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
mixin SearchUserRef on AutoDisposeFutureProviderRef<Profile?> {
  /// The parameter `username` of this provider.
  String get username;
}

class _SearchUserProviderElement
    extends AutoDisposeFutureProviderElement<Profile?>
    with SearchUserRef {
  _SearchUserProviderElement(super.provider);

  @override
  String get username => (origin as SearchUserProvider).username;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
