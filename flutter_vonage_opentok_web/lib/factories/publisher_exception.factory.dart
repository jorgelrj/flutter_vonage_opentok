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
      (_) => PublisherException(
          error.message,
          error.name,
        ),
    };
  }
}
