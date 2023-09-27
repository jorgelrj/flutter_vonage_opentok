import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';

class FlutterVonageOpentok {
  const FlutterVonageOpentok();

  FlutterVonageOpentokPlatform get _delegate {
    return FlutterVonageOpentokPlatform.instance;
  }

  /// Throws a [PublisherException] if the publisher fails to initialize.
  Future<Publisher> initPublisher({
    bool publishAudio = true,
    bool publishVideo = true,
  }) {
    return _delegate.initPublisher(
      publishAudio: publishAudio,
      publishVideo: publishVideo,
    );
  }

  VideoSession initSession(String apiKey, String sessionId) {
    return _delegate.initSession(apiKey, sessionId);
  }
}
