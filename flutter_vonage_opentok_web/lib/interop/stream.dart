import 'package:js/js.dart';

@JS()
@staticInterop
class JsStream {
  external factory JsStream();
}

extension JsStreamExtension on JsStream {
  external String get streamId;
}
