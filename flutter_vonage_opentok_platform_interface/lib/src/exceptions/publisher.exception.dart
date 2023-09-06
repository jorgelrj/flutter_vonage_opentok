class PublisherException implements Exception {
  final String message;
  final String errorCode;

  PublisherException(
    this.message,
    this.errorCode,
  );

  @override
  String toString() {
    return 'PublisherException: $message';
  }
}

class PublisherPermissionDeniedException extends PublisherException {
  PublisherPermissionDeniedException()
      : super(
          'Media permission denied',
          'OT_MEDIA_ERR_PERMISSION_DENIED',
        );
}

class PublisherDeviceNotFoundException extends PublisherException {
  PublisherDeviceNotFoundException()
      : super(
          'Device not found',
          'OT_MEDIA_ERR_NO_DEVICES_FOUND',
        );
}
