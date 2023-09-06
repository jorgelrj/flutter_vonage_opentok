import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vonage_opentok_platform_interface/src/models/models.dart';

abstract class Publisher {
  final ValueNotifier<bool> publishingAudioNotifier;
  final ValueNotifier<bool> publishingVideoNotifier;
  final ValueNotifier<bool> speakingNotifier;

  Publisher()
      : publishingAudioNotifier = ValueNotifier(true),
        publishingVideoNotifier = ValueNotifier(true),
        speakingNotifier = ValueNotifier(false);

  Future<void> cycleVideo();

  Future<List<IoDevice>> getIoDevices();

  Future<IoDevice?> getAudioInputDevice();

  Future<IoDevice?> getAudioOutputDevice();

  Future<IoDevice?> getVideoInputDevice();

  Uint8List getScreenshot();

  void publishAudio(bool publish) {
    publishingAudioNotifier.value = publish;
  }

  void publishVideo(bool publish) {
    publishingVideoNotifier.value = publish;
  }

  Future<void> setAudioInputDevice(String deviceId);

  Future<void> setAudioOutputDevice(String deviceId);

  Future<void> setVideoInputDevice(String deviceId);

  void dispose() {
    publishingAudioNotifier.dispose();
    publishingVideoNotifier.dispose();
    speakingNotifier.dispose();
  }
}
