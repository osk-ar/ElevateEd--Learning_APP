import 'package:ElevatED/core/constants/app_strings.dart';

class ErrorManager {
  ErrorManager._();

  static String getAPIErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AppStrings.statusCode400;
      case 401:
        return AppStrings.statusCode401;
      case 403:
        return AppStrings.statusCode403;
      case 404:
        return AppStrings.statusCode404;
      case 500:
        return AppStrings.statusCode500;
      case 503:
        return AppStrings.statusCode503;
      default:
        return AppStrings.statusCodeUnknown(statusCode.toString());
    }
  }
}

class UserFriendlyException implements Exception {
  final String message;
  UserFriendlyException(this.message);

  @override
  String toString() {
    Object? message = this.message;
    return "$message";
  }
}
