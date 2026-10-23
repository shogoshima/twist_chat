// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide connection: lives for the whole session and is rebuilt (closing the
/// previous channel) whenever the signed-in user changes.

@ProviderFor(WebSocket)
const webSocketProvider = WebSocketProvider._();

/// App-wide connection: lives for the whole session and is rebuilt (closing the
/// previous channel) whenever the signed-in user changes.
final class WebSocketProvider
    extends $AsyncNotifierProvider<WebSocket, WebSocketChannel?> {
  /// App-wide connection: lives for the whole session and is rebuilt (closing the
  /// previous channel) whenever the signed-in user changes.
  const WebSocketProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketHash();

  @$internal
  @override
  WebSocket create() => WebSocket();
}

String _$webSocketHash() => r'bdbd5e25480787443132e20b35fec0df8108725d';

/// App-wide connection: lives for the whole session and is rebuilt (closing the
/// previous channel) whenever the signed-in user changes.

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
