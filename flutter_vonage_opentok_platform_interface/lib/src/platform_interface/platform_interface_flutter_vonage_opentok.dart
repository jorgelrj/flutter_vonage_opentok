import 'package:flutter_vonage_opentok_platform_interface/src/method_channel/method_channel_flutter_vonage_opentok.dart';
import 'package:flutter_vonage_opentok_platform_interface/src/models/models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterVonageOpentokPlatform extends PlatformInterface {
  FlutterVonageOpentokPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVonageOpentokPlatform get instance {
    _instance ??= MethodChannelFlutterVonageOpentok.instance;
    return _instance!;
  }

  static FlutterVonageOpentokPlatform? _instance;

  static set instance(FlutterVonageOpentokPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<Publisher> initPublisher() {
    throw UnimplementedError('initPublisher() has not been implemented.');
  }

  VideoSession initSession(String apiKey, String sessionId) {
    throw UnimplementedError('initSession() has not been implemented.');
  }
}
