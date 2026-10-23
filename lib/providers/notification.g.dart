// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Notification)
const notificationProvider = NotificationProvider._();

final class NotificationProvider
    extends $AsyncNotifierProvider<Notification, Set<String>> {
  const NotificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHash();

  @$internal
  @override
  Notification create() => Notification();
}

String _$notificationHash() => r'558079a89d1a3094b9c593e1b562879e3a479f98';

abstract class _$Notification extends $AsyncNotifier<Set<String>> {
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
