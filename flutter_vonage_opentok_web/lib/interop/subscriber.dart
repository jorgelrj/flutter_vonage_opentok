@JS()

import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:js/js.dart';

@JS()
@staticInterop
class JsSubscriber {
  external factory JsSubscriber();
}

extension JsSubscriberExtension on JsSubscriber {
  external JsStream get stream;

  external String getImgData();

  external void on(String event, Function(JsEvent) fn);
}
