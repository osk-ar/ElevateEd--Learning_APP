import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';

class ValidationManager {
  ValidationManager._();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailIsRequired;
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired;
    }

    if (value.length < 8) {
      return AppStrings.passwordMustBe8Characters;
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    if (!hasUppercase) {
      return AppStrings.passwordMustHaveUppercase;
    }

    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    if (!hasLowercase) {
      return AppStrings.passwordMustHaveLowercase;
    }

    final hasDigit = value.contains(RegExp(r'[0-9]'));
    if (!hasDigit) {
      return AppStrings.passwordMustHaveNumbers;
    }

    final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasSpecialChar) {
      return AppStrings.passwordMustHaveSymbols;
    }

    return null;
  }

  static String? validateConfirmPassword(
      {String? password, String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.confirmPasswordIsRequired;
    }

    if (password != confirmPassword) {
      return AppStrings.passwordsDontMatch;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.numberIsRequired;
    }

    final phoneRegex = RegExp(r'^(01|\+201)\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return AppStrings.invalidNumber;
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'name_is_required'.tr();
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return AppStrings.nameMustHaveLettersOnly;
    }

    if (value.length < 2) {
      return AppStrings.nameMustHave2Letters;
    }

    return null;
  }

  static String? validateBirthDate(String? date) {
    if (date.isNullOrEmpty()) {
      return AppStrings.birthDateIsRequired;
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
      return 'enter_a_complete_url_including_http_or_https_'.tr();
    }

    // Validate based on the platform type
    switch (platformType) {
      case 1: // Facebook
        if (!facebookPattern.hasMatch(value)) {
          return 'please_enter_a_valid_facebook_link'.tr();
        }
        break;
      case 2: // LinkedIn
        if (!linkedInPattern.hasMatch(value)) {
          return 'please_enter_a_valid_linkedin_link'.tr();
        }
        break;
      case 3: // GitHub
        if (!githubPattern.hasMatch(value)) {
          return 'please_enter_a_valid_github_link'.tr();
        }
        break;
      default: // General portfolio or other links
        if (!validUrlPattern.hasMatch(value)) {
          return 'enter_a_valid_url'.tr();
        }
    }

    return null; // The input is valid
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'professional_title_is_required'.tr();
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'title_must_contain_only_alphabetic_characters'.tr();
    }

    if (value.length < 2) {
      return 'title_must_be_at_least_2_characters_long'.tr();
    }

    return null;
  }

  static String? validateCourseTitle(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.courseTitleIsRequired;
    }

    if (value.length < 5) {
      return AppStrings.courseTitleTooShort;
    }

    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    if (!hasLetter) {
      return AppStrings.courseTitleMustContainLetters;
    }

    return null;
  }

  static String? validateCourseDescription(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.courseDescriptionIsRequired;
    }

    if (value.length < 20) {
      return AppStrings.courseDescriptionTooShort;
    }

    final hasSentenceStructure = value.contains(RegExp(r'[.!?]'));
    if (!hasSentenceStructure) {
      return AppStrings.courseDescriptionMustBeSentenceLike;
    }

    return null;
  }

  static String? validateVideoTitle(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.videoTitleRequired;
    }

    if (value.length < 5) {
      return AppStrings.videoTitleMinLength;
    }

    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    if (!hasLetter) {
      return AppStrings.videoTitleLettersOnly;
    }

    return null;
  }

  static String? validateAssignmentTitle(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyAssignmentTitleError;
    }

    if (value.length < 5) {
      return AppStrings.shortAssignmentTitleError;
    }

    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    if (!hasLetter) {
      return AppStrings.noLettersInAssignmentTitleError;
    }

    return null;
  }

  static String? validateCoursePrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Price cannot be empty";
    }

    final isValid = RegExp(r'^\d+$').hasMatch(value);

    if (!isValid) {
      return "Price must be a valid number";
    }

    return null;
  }
}
