//ignore_for_file: constant_identifier_names

enum PublisherError {
  OT_HARDWARE_UNAVAILABLE,
  OT_INVALID_PARAMETER,
  OT_MEDIA_ENDED,
  OT_MEDIA_ERR_ABORTED,
  OT_MEDIA_ERR_DECODE,
  OT_USER_MEDIA_ACCESS_DENIED,
  OT_MEDIA_ERR_NETWORK,
  OT_MEDIA_ERR_SRC_NOT_SUPPORTED,
  OT_NOT_SUPPORTED,
  OT_NO_DEVICES_FOUND,
  OT_NO_VALID_CONSTRAINTS,
  OT_PROXY_URL_ALREADY_SET_ERROR,
  OT_REQUESTED_DEVICE_PERMISSION_DENIED,
  OT_SCREEN_SHARING_NOT_SUPPORTED,
  OT_UNABLE_TO_CAPTURE_SCREEN,
  OT_SCREEN_SHARING_EXTENSION_NOT_REGISTERED,
  OT_SCREEN_SHARING_EXTENSION_NOT_INSTALLED,
  UNKNOWN;

  factory PublisherError.fromString(String name) {
    return PublisherError.values.firstWhere(
      (e) => e.name == name,
      orElse: () => PublisherError.UNKNOWN,
    );
  }
}
