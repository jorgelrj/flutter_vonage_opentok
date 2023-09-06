@JS()

import 'dart:js_interop';

@JS()
@staticInterop
class JsConnection {
  external factory JsConnection();
}

extension JsConnectionExtension on JsConnection {
  external String get connectionId;
}
