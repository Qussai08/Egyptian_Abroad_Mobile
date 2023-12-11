import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

enum ToastType {
  hint,
  error,
  success,
}

extension ToastTypeExtension on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.success:
        return const Color(0xff00B25D);
      case ToastType.error:
        return const Color(0xffFF3D23);

      case ToastType.hint:
        return Styles.grey_400;

      default:
        return const Color(0xff00B25D);
    }
  }
}

GetSnackBar buildCustomToast(
  BuildContext context, {
  required String toastMsg,
  required String toastTitle,
  required ToastType toastType,
}) {
  return GetSnackBar(
    titleText: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        toastType == ToastType.error
            ? Icon(
                Icons.error,
                color: Colors.white,
                size: fixDpiHeight(24),
              )
            : Icon(
                Icons.check_circle,
                color: Colors.white,
                size: fixDpiHeight(24),
              ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          toastTitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: fixDpiFont(18),
              fontWeight: FontWeight.w700,
              fontFamily: "baloo"),
        ),
      ],
    ),
    messageText: Text(
      toastMsg,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontSize: fixDpiFont(14),
          fontWeight: FontWeight.w400,
          fontFamily: "baloo"),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: toastType.backgroundColor,
    borderRadius: 16,
    margin: const EdgeInsets.only(bottom: 0),
    padding: const EdgeInsets.only(top: 12, bottom: 10),
    snackStyle: SnackStyle.GROUNDED,
  );
}
