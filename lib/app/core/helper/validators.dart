import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';

  String? validateName(String name) {
    if (name.trim().isEmpty) {
      return AppStrings.nameEmptyValidation.tr;
    }
    return null;
  }

  String? validateNationalID(String nationalID) {
    if (nationalID.isEmpty) {
      return AppStrings.nationalIDEmptyValidation.tr;
    } else if (int.tryParse(nationalID) == null) {
      return AppStrings.onlyNumericValidation.tr;
    } else if (nationalID.length != 14) {
      return AppStrings.nationalIDShortValidation.tr;
    }

    return null;
  }

  String? validateUserEmail(String userEmail) {
    if (userEmail.trim().isEmpty) {
      return AppStrings.emailEmptyValidation.tr;
    } else if (!isEmail(userEmail)) {
      return AppStrings.emailFormatValidation.tr;
    }

    return null;
  }

  String? validateOtpCode(String otpCode) {
    if (otpCode.trim().isEmpty) {
      return AppStrings.otpEmptyValidation.tr;
    } else if (int.tryParse(otpCode) == null) {
      return AppStrings.onlyNumericValidation.tr;
    } else if (otpCode.length != 4) {
      return AppStrings.otpShortValidation.tr;
    }
    return null;
  }

  // String validateOldPassword(String oldPassword) {
  //   if (oldPassword.trim().length == 0) {
  //     return AppLocalizations.of(context).translate('old_password_validation');
  //   }
  //   return null;
  // }

  String? validatePassword(String password) {
    _password = password;
    if (password.trim().isEmpty) {
      return AppStrings.passwordEmptyValidation.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String confirmPassword) {
    if (confirmPassword.trim().isEmpty) {
      return AppStrings.passwordEmptyValidation.tr;
    } else if (_password != confirmPassword) {
      return AppStrings.confirmPasswordValidation.tr;
    }
    return null;
  }

  bool atLeastOneNumberString(String stringToCheck) {
    if (RegExp(r'\w*\d{1,}\w*').hasMatch(stringToCheck)) {
      return true;
    } else {
      return false;
    }
  }

  bool atLeastOneCharString(String stringToCheck) {
    if (RegExp(r'[A-Za-z\u0621-\u064A\u0660-\u0669 ]')
        .hasMatch(stringToCheck)) {
      return true;
    } else {
      return false;
    }
  }

  bool atLeastOneSpecialCharString(String stringToCheck) {
    if (RegExp(
            r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' // <-- Notice the escaped symbols
            "'" // <-- ' is added to the expression
            ']')
        .hasMatch(stringToCheck)) {
      return true;
    } else {
      return false;
    }
  }

  bool passMinimumLenght(String text) {
    if (text.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}
