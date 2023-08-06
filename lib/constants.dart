class Constants {
  /// USER AUTHENTICATION CONSTANTS
  static const String USER_AUTH_WRONG_CREDENTIALS =
      'Invalid Credentials, Please check.';
  static const String USER_AUTH_USER_NOT_FOUND =
      'User Not found, try Signing Up.';
  static const String USER_NOT_AUTHORIZED_TO_FETCH_USER =
      'You are not authorized to fetch this User';
  static const String USER_NOT_FOUND = 'No User Found';

  /// MENU CONSTANTS
  static const String MENU_NOT_FOUND = 'No Menu Found';

  /// GENERIC FAILURE CONSTANTS
  static const String BAD_RESPONSE_FORMAT = 'Bad Response Format';
  static const String GENERIC_FAILURE =
      'Something Wrong Occured! Please try again.';
  static const String NO_INTERNET_CONNECTION = 'No Internet Connection';
  static const String HTTP_EXCEPTION = 'Unable to fetch response';
  static const String UNAUTHORIZED_EXCEPTION =
      'Unauthorized to fetch the resource.';
  static const List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  static const Map<String, String> dayToInitial = {
    "Monday": "M",
    "Tuesday": "T",
    "Wednesday": "W",
    "Thursday": "T",
    "Friday": "F",
    "Saturday": "S",
    "Sunday": "S"
  };
}
