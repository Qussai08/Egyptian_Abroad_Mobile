import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType {
  error,
  success,
}

extension DialogTypeExtension on DialogType {
  Color get backgroundColor {
    switch (this) {
      case DialogType.success:
        return const Color(0xff00B25D);
      case DialogType.error:
        return const Color(0xffFF3D23);

      default:
        return const Color(0xff00B25D);
    }
  }
}

Future<dynamic> buildCustomDialog({
  required String dialogMsg,
  required DialogType dialogType,
}) {
  return Get.defaultDialog(
      title: "",
      contentPadding: EdgeInsets.all(0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dialogType == DialogType.error
              ? Icon(
                  Icons.error,
                  color: Color(0xffff0000),
                  size: fixDpiHeight(21),
                )
              : Icon(
                  Icons.check_circle,
                  color: const Color(0xff00B25D),
                  size: fixDpiHeight(21),
                ),
          SizedBox(
            height: fixDpiHeight(20),
          ),
          Text(
            dialogMsg,
            style: TextStyle(
                fontFamily: "baloo",
                fontSize: fixDpiFont(14),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: fixDpiHeight(20),
          ),
        ],
      ));
}
