class SessionConnectException implements Exception {
  final String message;
  final String errorCode;

  SessionConnectException(
    this.message,
    this.errorCode,
  );

  @override
  String toString() {
    return 'SessionConnectException: $message';
  }
}

class SessionConnectAuthException extends SessionConnectException {
  SessionConnectAuthException(
    super.message,
    super.errorCode,
  );
}

class SessionConnectNoInternet extends SessionConnectException {
  SessionConnectNoInternet(
    super.message,
    super.errorCode,
  );
}

class SessionConnectNotSupported extends SessionConnectException {
  SessionConnectNotSupported(
    super.message,
    super.errorCode,
  );
}

class SessionConnectTimeoutException extends SessionConnectException {
  SessionConnectTimeoutException()
      : super(
          'Session connect timed out',
          'OT_SESSION_CONNECT_TIMEOUT',
        );
}
