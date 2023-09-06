import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:js/js_util.dart';

class IoDeviceFactory {
  static IoDevice fromJs(Object object) {
    return IoDevice(
      id: getProperty(object, 'deviceId') as String,
      label: getProperty(object, 'label') as String,
      type: IoDeviceType.values.firstWhere(
        (element) => element.name == getProperty(object, 'kind') as String,
      ),
    );
  }

  static IoDevice fromJsWithType(
    Object object, {
    required IoDeviceType type,
  }) {
    return IoDevice(
      id: getProperty(object, 'deviceId') as String,
      label: getProperty(object, 'label') as String,
      type: type,
    );
  }
}
