import 'package:e_learning_app_gp/core/helper/extensions.dart';

class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    if (!hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }

    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    if (!hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }

    final hasDigit = value.contains(RegExp(r'[0-9]'));
    if (!hasDigit) {
      return 'Password must contain at least one number';
    }

    final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasSpecialChar) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateConfirmPassword(
      {String? password, String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^(01|\+201)\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number'; // Phone number must start with 01 or +201 and contain 9 digits after
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name must contain only alphabetic characters';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  static String? validateBirthDate(String? date) {
    if (date.isNullOrEmpty()) {
      return 'Birthdate is required';
    }

    return null;
  }

  static String? linkValidator(String? value, int platformType) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Regular expressions for validating specific platform links
    final validUrlPattern = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');
    final facebookPattern = RegExp(
        r'^(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?$');
    final linkedInPattern =
        RegExp(r'^https:\\/\\/[a-z]{2,3}\\.linkedin\\.com\\/.*$');
    final githubPattern = RegExp(r'^https?://github.com/([a-zA-Z0-9._-]+)$');

    if (!validUrlPattern.hasMatch(value)) {
      return 'Enter a complete URL including http:// or https://';
    }

    // Validate based on the platform type
    switch (platformType) {
      case 1: // Facebook
        if (!facebookPattern.hasMatch(value)) {
          return 'Please enter a valid Facebook link';
        }
        break;
      case 2: // LinkedIn
        if (!linkedInPattern.hasMatch(value)) {
          return 'Please enter a valid LinkedIn link';
        }
        break;
      case 3: // GitHub
        if (!githubPattern.hasMatch(value)) {
          return 'Please enter a valid GitHub link';
        }
        break;
      default: // General portfolio or other links
        if (!validUrlPattern.hasMatch(value)) {
          return 'Enter a valid Url';
        }
    }

    return null; // The input is valid
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Professional Title is required';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Title must contain only alphabetic characters';
    }

    if (value.length < 2) {
      return 'Title must be at least 2 characters long';
    }

    return null;
  }
}
