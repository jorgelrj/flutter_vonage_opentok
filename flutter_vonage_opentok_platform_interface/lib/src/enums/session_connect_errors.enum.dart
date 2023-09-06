// ignore_for_file: constant_identifier_names

enum SessionConnectError {
  OT_AUTHENTICATION_ERROR,
  OT_BADLY_FORMED_RESPONSE,
  OT_CONNECT_FAILED,
  OT_CONNECTION_LIMIT_EXCEEDED,
  OT_EMPTY_RESPONSE_BODY,
  OT_INVALID_SESSION_ID,
  OT_INVALID_PARAMETER,
  OT_NOT_CONNECTED,
  OT_TERMS_OF_SERVICE_FAILURE,
  OT_INVALID_HTTP_STATUS,
  OT_XDOMAIN_OR_PARSING_ERROR,
  OT_INVALID_ENCRYPTION_SECRET,
  OT_UNSUPPORTED_BROWSER,
  UNKNOWN;

  factory SessionConnectError.fromString(String name) {
    return SessionConnectError.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SessionConnectError.UNKNOWN,
    );
  }
}
