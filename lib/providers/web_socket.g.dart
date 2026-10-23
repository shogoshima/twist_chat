// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WebSocket)
const webSocketProvider = WebSocketProvider._();

final class WebSocketProvider
    extends $AsyncNotifierProvider<WebSocket, WebSocketChannel?> {
  const WebSocketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketHash();

  @$internal
  @override
  WebSocket create() => WebSocket();
}

String _$webSocketHash() => r'ecabedd5557c378fe7edda0d524f368da1e3929a';

abstract class _$WebSocket extends $AsyncNotifier<WebSocketChannel?> {
  FutureOr<WebSocketChannel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<WebSocketChannel?>, WebSocketChannel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebSocketChannel?>, WebSocketChannel?>,
              AsyncValue<WebSocketChannel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
