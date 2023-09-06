@JS()
import 'package:js/js.dart';

@JS()
@anonymous
class SessionProperties {
  external factory SessionProperties({
    num audioLevel,
    String fitMode,
    String insertMode,
    String width,
    String height,
    bool showControls,
    bool publishAudio,
    bool publishVideo,
  });
}
