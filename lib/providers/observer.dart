import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final class MyObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    log('Provider ${context.provider} was initialized');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    log('Provider ${context.provider} was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    log('Provider ${context.provider} updated');
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    log('Provider ${context.provider} threw $error');
  }
}
