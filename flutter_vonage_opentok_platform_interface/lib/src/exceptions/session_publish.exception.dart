class SessionPublishException implements Exception {
  final String message;
  final String errorCode;

  SessionPublishException(
    this.message,
    this.errorCode,
  );

  @override
  String toString() {
    return 'SessionPublishException: $message';
  }
}

class SessionPublishTimeoutException extends SessionPublishException {
  SessionPublishTimeoutException()
      : super(
          'Session publish timed out',
          'OT_PUBLISH_TIMEOUT',
        );
}
