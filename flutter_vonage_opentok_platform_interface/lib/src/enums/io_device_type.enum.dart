enum IoDeviceType {
  audioInput,
  audioOutput,
  videoInput;

  bool get isAudioInput => this == IoDeviceType.audioInput;

  bool get isAudioOutput => this == IoDeviceType.audioOutput;

  bool get isVideoInput => this == IoDeviceType.videoInput;
}
