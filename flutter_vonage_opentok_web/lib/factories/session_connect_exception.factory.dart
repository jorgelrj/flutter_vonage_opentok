import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';

class SessionConnectExceptionFactory {
  static SessionConnectException fromJsError(JsError error) {
    final enumError = SessionConnectError.fromString(error.name);

    return switch (enumError) {
      (SessionConnectError.OT_AUTHENTICATION_ERROR) => SessionConnectAuthException(
          error.message,
          error.name,
        ),
      (SessionConnectError.OT_NOT_CONNECTED) => SessionConnectNoInternet(
          error.message,
          error.name,
        ),
      (SessionConnectError.OT_UNSUPPORTED_BROWSER) => SessionConnectNotSupported(
          error.message,
          error.name,
        ),
      (_) => SessionConnectException(
          error.message,
          error.name,
        ),
    };
  }
}
