import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import 'package:flutter/services.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';

  String? validateName(String name) {
    if (name.trim().isEmpty) {
      return AppStrings.emptyValidation.tr;
    } else if (name.length > 100) {
      return "${AppStrings.maxlength.tr}100 ${AppStrings.char.tr}";
    }
    return null;
  }

  String? validateNationalID(String nationalID) {
    if (nationalID.isEmpty) {
      return AppStrings.emptyValidation.tr;
    } else if (int.tryParse(nationalID) == null) {
      return AppStrings.onlyNumericValidation.tr;
    } else if (nationalID.length != 14) {
      return AppStrings.nationalIDShortValidation.tr;
    } else if (!RegExp(r'(2|3)[0-9][0-9][0-1][1-9][0-3][0-9][00-88]\d\d\d\d\d')
        .hasMatch(nationalID)) {
      return AppStrings.nationalIDWrongValidation.tr;
    }

    return null;
  }

  String? validateUserEmail(String userEmail) {
    if (userEmail.trim().isEmpty) {
      return AppStrings.emptyValidation.tr;
    } else if (userEmail.length > 100) {
      return "${AppStrings.maxlength.tr}100 ${AppStrings.char.tr}";
    } else if (!isEmail(userEmail)) {
      return AppStrings.emailFormatValidation.tr;
    }

    return null;
  }

  String? validateCountry(String? country) {
    if (country == null || country == "null" || country.trim().isEmpty) {
      return AppStrings.emptyValidation.tr;
    } else {
      return null;
    }
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
      return AppStrings.emptyValidation.tr;
    } else if (password.length > 100) {
      return "${AppStrings.maxlength.tr}100 ${AppStrings.char.tr}";
    }
    return null;
  }

  String? validateConfirmPassword(String confirmPassword) {
    if (confirmPassword.trim().isEmpty) {
      return AppStrings.emptyValidation.tr;
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

  String? maxLenghtValidation(String text, int max) {
    if (text.length > max) {
      return "${AppStrings.maxlength.tr}$max ${AppStrings.char.tr}";
    } else {
      return null;
    }
  }

  String? validateEgyptionPassport(String passport) {
    if (passport.trim().isNotEmpty && passport.length != 9) {
      return AppStrings.passportShortValidation.tr;
    } else if (passport.trim().isNotEmpty &&
        !RegExp(r'(A|D|M|S)\d\d\d\d\d\d\d\d').hasMatch(passport)) {
      return AppStrings.passportWrongValidation.tr;
    }

    return null;
  }

  String? validateEgyptionPhoneNum(String phoneNum) {
    if (phoneNum.trim().isNotEmpty && phoneNum.length != 11) {
      return AppStrings.egPhoneNumShortValidation.tr;
    } else if (phoneNum.trim().isNotEmpty &&
        !RegExp(r'(01)[0-9]{9}').hasMatch(phoneNum)) {
      return AppStrings.egPhoneNumWrongValidation.tr;
    }

    return null;
  }
}
