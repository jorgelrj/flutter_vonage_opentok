import 'package:flutter_vonage_opentok_platform_interface/src/enums/enums.dart';

class IoDevice {
  final String id;
  final String label;
  final IoDeviceType type;

  IoDevice({
    required this.id,
    required this.label,
    required this.type,
  });

  @override
  String toString() => label;
}
