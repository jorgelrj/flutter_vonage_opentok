import 'dart:async';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:flutter_vonage_opentok_platform_interface/flutter_vonage_opentok_platform_interface.dart';
import 'package:flutter_vonage_opentok_web/factories/factories.dart';
import 'package:flutter_vonage_opentok_web/interop/interop.dart' as interop;

class WebPublisher extends Publisher {
  final interop.JsPublisher _jsPublisher;

  WebPublisher._(this._jsPublisher) : super() {
    _jsPublisher.on(
      'audioLevelUpdated',
      allowInterop(
        (event) {
          speakingNotifier.value = event.audioLevel > 0.2;
        },
      ),
    );
  }

  factory WebPublisher.fromJs(interop.JsPublisher obj) {
    return WebPublisher._(obj);
  }

  interop.JsPublisher get jsPublisher => _jsPublisher;

  @override
  Future<void> cycleVideo() async {
    try {
      await promiseToFuture(
        _jsPublisher.cycleVideo(),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<List<IoDevice>> getIoDevices() async {
    if (!_jsPublisher.grantedMediaAccess) {
      throw PublisherPermissionDeniedException();
    }

    final devicesLists = await Future.wait([
      _getAudioOutputDevices(),
      _getMediaInputDevices(),
    ]);

    return devicesLists.expand((element) => element).toList();
  }

  @override
  Future<IoDevice?> getAudioInputDevice() async {
    final mediaTrack = _jsPublisher.getAudioSource();

    if (mediaTrack != null) {
      final id = mediaTrack.id;
      final label = mediaTrack.label;

      if (id == null || label == null) {
        return null;
      }

      return IoDevice(
        id: mediaTrack.id!,
        label: mediaTrack.label!,
        type: IoDeviceType.audioInput,
      );
    }
  }

  @override
  Future<IoDevice?> getAudioOutputDevice() async {
    final jsObject = await promiseToFuture(
      interop.getActiveAudioOutputDevice(),
    );

    if (jsObject == null) {
      return null;
    }

    return IoDeviceFactory.fromJsWithType(
      jsObject,
      type: IoDeviceType.audioOutput,
    );
  }

  @override
  Future<IoDevice?> getVideoInputDevice() async {
    final jsObject = _jsPublisher.getVideoSource();

    if (jsObject != null) {
      final id = getProperty(jsObject, 'deviceId');
      final label = getProperty(jsObject, 'type');

      if (id == null || label == null) {
        return null;
      }

      return IoDevice(
        id: id,
        label: label,
        type: IoDeviceType.videoInput,
      );
    }
  }

  @override
  void publishAudio(bool publish) {
    _jsPublisher.publishAudio(publish);

    super.publishAudio(publish);
  }

  @override
  void publishVideo(bool publish) {
    _jsPublisher.publishVideo(publish);

    super.publishVideo(publish);
  }

  @override
  Future<void> setAudioInputDevice(String deviceId) async {
    try {
      await promiseToFuture(
        _jsPublisher.setAudioSource(deviceId),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> setAudioOutputDevice(String deviceId) async {
    try {
      await promiseToFuture(
        interop.setAudioOutputDevice(deviceId),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> setVideoInputDevice(String deviceId) async {
    try {
      await promiseToFuture(
        _jsPublisher.setVideoSource(deviceId),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Uint8List getScreenshot() => _jsPublisher.getImgData();

  @override
  void dispose() {
    _jsPublisher.destroy();

    super.dispose();
  }

  Future<List<IoDevice>> _getAudioOutputDevices() async {
    final jsObjects = await promiseToFuture(
      interop.getAudioOutputDevices(),
    );

    return jsObjects.map<IoDevice>(
      (jsObject) {
        return IoDeviceFactory.fromJsWithType(
          jsObject,
          type: IoDeviceType.audioOutput,
        );
      },
    ).toList();
  }

  Future<List<IoDevice>> _getMediaInputDevices() async {
    final completer = Completer<List<IoDevice>>();

    interop.getDevices(
      allowInterop(
        (error, jsList) {
          if (error != null) {
            completer.completeError(error);
          } else {
            final devices = jsList.map<IoDevice>(
              //ignore: unnecessary_lambdas
              (jsObject) {
                return IoDeviceFactory.fromJs(jsObject);
              },
            ).toList();

            completer.complete(devices);
          }
        },
      ),
    );

    return completer.future;
  }
}
