import 'package:flutter/foundation.dart';
import 'package:flutter_vonage_opentok_platform_interface/src/enums/enums.dart';
import 'package:flutter_vonage_opentok_platform_interface/src/exceptions/exceptions.dart';
import 'package:flutter_vonage_opentok_platform_interface/src/models/models.dart';

abstract class VideoSession {
  const VideoSession();

  Stream<VideoSessionEvents> get eventStream;

  /// Throws [SessionConnectException] if the connection fails.
  Future<void> connect(String token);

  /// Throws [SessionPublishException] if the connection fails.
  Future<void> publish(Publisher publisher);

  void dispose();
}

abstract class VideoSessionEvents {
  const VideoSessionEvents();
}

class PublisherConnected extends VideoSessionEvents {
  const PublisherConnected();
}

class SubscriberConnected extends VideoSessionEvents {
  const SubscriberConnected();
}

class SubscriberDestroyed extends VideoSessionEvents {
  const SubscriberDestroyed();
}

class SubscriberLost extends VideoSessionEvents {
  const SubscriberLost();
}

class SubscriberImageData extends VideoSessionEvents {
  final Uint8List data;

  const SubscriberImageData(this.data);
}

class SubscriberVideoDisabled extends VideoSessionEvents {
  final VideoDisabledReasons reason;

  const SubscriberVideoDisabled(this.reason);
}
