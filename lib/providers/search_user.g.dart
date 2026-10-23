// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchUser)
const searchUserProvider = SearchUserFamily._();

final class SearchUserProvider
    extends
        $FunctionalProvider<AsyncValue<Profile?>, Profile?, FutureOr<Profile?>>
    with $FutureModifier<Profile?>, $FutureProvider<Profile?> {
  const SearchUserProvider._({
    required SearchUserFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchUserProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchUserHash();

  @override
  String toString() {
    return r'searchUserProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Profile?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Profile?> create(Ref ref) {
    final argument = this.argument as String;
    return searchUser(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchUserProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchUserHash() => r'e0a7fc651c03c8e35958adc38c5fcfbe3c420ed6';

final class SearchUserFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Profile?>, String> {
  const SearchUserFamily._()
    : super(
        retry: null,
        name: r'searchUserProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchUserProvider call(String username) =>
      SearchUserProvider._(argument: username, from: this);

  @override
  String toString() => r'searchUserProvider';
}
