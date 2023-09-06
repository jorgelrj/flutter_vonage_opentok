import 'package:flutter_vonage_opentok_web/interop/interop.dart';
import 'package:js/js.dart';

@JS()
@staticInterop
class JsEvent {
  external factory JsEvent();
}

extension JsEventExtension on JsEvent {
  @JS('audioLevel')
  external num? get _audioLevel;
  num get audioLevel => _audioLevel ?? 0;

  external bool get cancelable;

  external JsConnection? get connection;

  external String? get reason;

  external JsStream? get stream;

  external dynamic get target;

  external String get type;

  external void preventDefault();

  external bool isDefaultPrevented();
}
