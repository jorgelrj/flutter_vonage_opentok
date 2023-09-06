@JS()

import 'dart:convert';
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:js/js.dart';

@JS()
@staticInterop
class JsPublisher {
  external factory JsPublisher();
}

extension JsPublisherExtension on JsPublisher {
  @JS('accessAllowed')
  external bool get _accessAllowed;
  bool get grantedMediaAccess => _accessAllowed;

  external Future cycleVideo();

  external void destroy();

  external MediaStreamTrack? getAudioSource();

  external Object? getVideoSource();

  @JS('getImgData')
  external String _getImgData();
  Uint8List getImgData() {
    return base64Decode(
      _getImgData(),
    );
  }

  external void on(String event, Function(JsEvent) fn);

  external void publishAudio(bool publish);

  external void publishVideo(bool publish);

  external Object setAudioSource(String audioSourceId);

  external Object setVideoSource(String videoSourceId);
}
