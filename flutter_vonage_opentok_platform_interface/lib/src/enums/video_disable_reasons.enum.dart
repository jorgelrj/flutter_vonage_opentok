enum VideoDisabledReasons {
  codecNotSupported,
  publishVideo,
  quality,
  subscribeToVideo,
  unknown;

  static VideoDisabledReasons fromReason(String reason) {
    return VideoDisabledReasons.values.firstWhere(
      (e) => e.name == reason,
      orElse: () => VideoDisabledReasons.unknown,
    );
  }
}
