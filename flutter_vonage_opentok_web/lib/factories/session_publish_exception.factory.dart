import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';

class SessionPublishExceptionFactory {
  static SessionPublishException fromJsError(JsError error) {
    final enumError = SessionConnectError.fromString(error.name);

    return switch (enumError) {
      (_) => SessionPublishException(
          error.message,
          error.name,
        ),
    };
  }
}
