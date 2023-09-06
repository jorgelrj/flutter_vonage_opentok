import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/factories/factories.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:flutter_vonage_opentok_web/interop/ot.dart' as ot_interop;
import 'package:flutter_vonage_opentok_web/models/models.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

class FlutterVonageOpentokWeb extends FlutterVonageOpentokPlatform {
  static void registerWith(Registrar registrar) {
    FlutterVonageOpentokPlatform.instance = FlutterVonageOpentokWeb();
  }

  @override
  VideoSession initSession(String apiKey, String sessionId) {
    debugPrint(
      '''
      Initializing session:
        - apiKey: $apiKey
        - sessionId: $sessionId
      ''',
    );

    final jsSession = ot_interop.initSession(
      apiKey,
      sessionId,
    );

    return WebVideoSession.fromJs(jsSession);
  }

  @override
  Future<Publisher> initPublisher() async {
    final completer = Completer();

    final jsPublisher = ot_interop.initPublisher(
      VonageOpentok.publisherVideoElement,
      SessionProperties(
        fitMode: 'cover',
        width: '100%',
        height: '100%',
        showControls: false,
        publishAudio: true,
        publishVideo: true,
      ),
      allowInterop(
        ([error]) {
          if (error != null) {
            completer.completeError(
              PublisherExceptionFactory.fromJsError(error),
            );
          } else {
            completer.complete();
          }
        },
      ),
    );

    await completer.future.catchError((error) {
      debugPrint('Error initializing publisher: $error');

      throw error;
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        debugPrint('Publisher initialization timed out');

        throw PublisherException(
          'Publisher initialization timed out',
          'OT_ERR_TIMEOUT',
        );
      },
    );

    debugPrint('Publisher initialized');

    return WebPublisher.fromJs(jsPublisher);
  }
}
