@JS('OT')
library ot_interop;

import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:js/js.dart';

@JS()
external void setLogLevel(int logLevel);

@JS()
external Future<Object> getActiveAudioOutputDevice();

@JS()
external Future<List> getAudioOutputDevices();

@JS()
external void getDevices(void Function(JsError?, List) callback);

@JS()
external JsPublisher initPublisher(
  Object targetElement,
  SessionProperties properties,
  void Function([JsError?]) completionHandler,
);

@JS()
external JsVideoSession initSession(
  String apiKey,
  String sessionId,
);

@JS()
external Future setAudioOutputDevice(String deviceId);
