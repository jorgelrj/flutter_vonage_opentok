import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:js/js.dart';

@JS()
@staticInterop
class JsVideoSession {
  external factory JsVideoSession();
}

extension JsVideoSessionExtension on JsVideoSession {
  external JsVideoSession? connect(
    String token,
    void Function([JsError?, Object?]) completionHandler,
  );

  @JS('disconnect')
  external void _disconnect();
  Future<void> disconnect() async {
    final completer = Completer<void>();

    once(
      'sessionDisconnected',
      allowInterop((event) {
        debugPrint('Session.disconnect.success');
        event.preventDefault();
        completer.complete();
      }),
    );

    _disconnect();

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () => null,
    );
  }

  external bool isConnected();

  external void off();

  external void on(String event, Function(JsEvent) fn);

  external void once(String event, Function(JsEvent) fn);

  external void publish(
    JsPublisher publisher,
    SessionProperties? properties,
    void Function([JsError?, Object?]) completionHandler,
  );

  external JsSubscriber subscribe(
    JsStream stream,
    Object targetElement,
    SessionProperties properties,
  );
}
