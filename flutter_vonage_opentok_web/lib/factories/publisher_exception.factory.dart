import 'package:flutter/foundation.dart';
import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart';

class PublisherExceptionFactory {
  static PublisherException fromJsError(JsError error) {
    debugPrint(
      '''
      PublisherExceptionFactory.fromJsError:
        - error: $error
      ''',
    );

    final enumError = PublisherError.fromString(error.name);

    return switch (enumError) {
      (PublisherError.OT_USER_MEDIA_ACCESS_DENIED) => PublisherPermissionDeniedException(),
      (PublisherError.OT_REQUESTED_DEVICE_PERMISSION_DENIED) => PublisherPermissionDeniedException(),
      (PublisherError.OT_HARDWARE_UNAVAILABLE) => PublisherHardwareUnavailableException(),
      (_) => PublisherException(
          error.message,
          error.name,
        ),
    };
  }
}
