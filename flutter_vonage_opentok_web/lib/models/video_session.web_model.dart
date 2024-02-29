import 'dart:async';
import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/factories/factories.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:flutter_vonage_opentok_web/models/models.dart';

class WebVideoSession extends VideoSession {
  final JsVideoSession _jsVideoSession;
  final StreamController<VideoSessionEvents> _streamController;

  WebVideoSession._(
    this._jsVideoSession,
  ) : _streamController = StreamController<VideoSessionEvents>() {
    _jsVideoSession.off();
    _subscribeSessionEvents();
  }

  factory WebVideoSession.fromJs(JsVideoSession obj) {
    return WebVideoSession._(obj);
  }

  @override
  Stream<VideoSessionEvents> get eventStream {
    return _streamController.stream.asBroadcastStream();
  }

  @override
  Future<void> connect(String token) async {
    if (kDebugMode) {
      debugPrint('''
        Connecting to session
         - token: $token
        ''');
    }

    final completer = Completer<void>();

    final session = _jsVideoSession.connect(
      token,
      allowInterop(([error, _]) {
        if (error != null) {
          final exception = SessionConnectExceptionFactory.fromJsError(error);

          completer.completeError(exception);
        } else {
          debugPrint('Session.connect.success');

          completer.complete();
        }
      }),
    );

    if (session?.isConnected() == true) {
      await session!.disconnect();

      return connect(token);
    }

    return completer.future.catchError((e) {
      debugPrint('Session.connect.error: $e');

      throw e;
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () async {
        debugPrint('Session.connect.timeout');

        throw SessionConnectTimeoutException();
      },
    );
  }

  @override
  Future<void> publish(Publisher publisher) async {
    final completer = Completer<void>();

    _jsVideoSession.publish(
      (publisher as WebPublisher).jsPublisher,
      null,
      allowInterop(
        ([error, _]) {
          if (error != null) {
            final exception = SessionPublishExceptionFactory.fromJsError(error);

            completer.completeError(exception);
          } else {
            debugPrint('Session.publish.success');

            completer.complete();
          }
        },
      ),
    );

    return completer.future.catchError((e) {
      debugPrint('Session.publish.error: $e');

      throw e;
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () async {
        debugPrint('Session.publish.timeout');

        throw SessionPublishTimeoutException();
      },
    );
  }

  void _subscribeSessionEvents() {
    _jsVideoSession.on(
      'streamCreated',
      allowInterop(_subscribeSubscriberEvents),
    );

    _jsVideoSession.on(
      'streamDestroyed',
      allowInterop((event) {
        debugPrint('Session.on.streamDestroyed: ${event.stream?.streamId}');

        event.preventDefault();

        _streamController.add(
          event.reason == 'networkDisconnected' ? const SubscriberLost() : const SubscriberDestroyed(),
        );
      }),
    );

    _jsVideoSession.on(
      'sessionDisconnected',
      allowInterop((event) {
        debugPrint('Session.on.sessionDisconnected');
      }),
    );

    _jsVideoSession.on(
      'connectionCreated',
      allowInterop((event) {
        debugPrint(
          'Session.on.connectionCreated: ${event.connection?.connectionId}',
        );
      }),
    );

    _jsVideoSession.on(
      'connectionDestroyed',
      allowInterop((event) {
        debugPrint('Session.on.connectionDestroyed');
      }),
    );

    _jsVideoSession.on(
      'sessionConnected',
      allowInterop((event) {
        debugPrint('Session.on.sessionConnected');
      }),
    );

    _jsVideoSession.on(
      'sessionReconnecting',
      allowInterop((event) {
        debugPrint('Session.on.sessionReconnecting');
      }),
    );

    _jsVideoSession.on(
      'sessionReconnected',
      allowInterop((event) {
        debugPrint('Session.on.sessionReconnected');
      }),
    );

    _jsVideoSession.on(
      'signal',
      allowInterop((event) {
        debugPrint('Session.on.signal');
      }),
    );
  }

  void _subscribeSubscriberEvents(JsEvent event) {
    debugPrint('Session.on.streamCreated ${event.stream?.streamId}');

    Timer? timer;
    final subscriber = _jsVideoSession.subscribe(
      event.stream!,
      VonageOpentok.subscriberVideoElement,
      SessionProperties(
        audioLevel: 100,
        fitMode: 'contain',
        width: '100%',
        height: '100%',
        showControls: false,
      ),
    );

    subscriber.on(
      'videoDisabled',
      allowInterop((event) {
        debugPrint('Subscriber.on.videoDisabled.${event.reason}');

        _streamController.add(
          SubscriberVideoDisabled(
            VideoDisabledReasons.fromReason(event.reason!),
          ),
        );
      }),
    );

    subscriber.on(
      'connected',
      allowInterop((event) {
        debugPrint('Subscriber.on.connected: ${subscriber.stream.streamId}');

        _streamController.sink.add(
          const SubscriberConnected(),
        );

        timer?.cancel();
        timer = Timer.periodic(
          const Duration(minutes: 5),
          (_) {
            try {
              final imageData = subscriber.getImgData();

              _streamController.add(
                SubscriberImageData(base64Decode(imageData)),
              );
            } catch (e) {
              debugPrint('Error getting subscriber image data: $e');
            }
          },
        );
      }),
    );

    subscriber.on(
      'disconnected',
      allowInterop((event) {
        debugPrint('Subscriber.on.disconnected');
        _streamController.add(const SubscriberLost());
        timer?.cancel();
      }),
    );

    subscriber.on(
      'destroyed',
      allowInterop((event) {
        debugPrint('Subscriber.on.destroyed');
        _streamController.add(const SubscriberDestroyed());
        timer?.cancel();
      }),
    );

    subscriber.on(
      'videoEnabled',
      allowInterop((event) {
        debugPrint('Subscriber.on.videoEnabled');
      }),
    );

    subscriber.on(
      'videoDisableWarning',
      allowInterop((event) {
        debugPrint('Subscriber.on.videoDisableWarning');
      }),
    );

    subscriber.on(
      'videoDisableWarningLifted',
      allowInterop((event) {
        debugPrint('Subscriber.on.videoDisableWarningLifted');
      }),
    );

    _streamController.add(const SubscriberConnected());
  }

  @override
  void dispose() {
    _jsVideoSession.disconnect();
  }
}
