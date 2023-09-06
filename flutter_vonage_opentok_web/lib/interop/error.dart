@JS()

import 'package:js/js.dart';

@JS()
@staticInterop
class JsError {
  external factory JsError();
}

extension JSErrorExtension on JsError {
  external int get code;

  external String get message;

  external String get name;
}
