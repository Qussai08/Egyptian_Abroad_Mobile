import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class ValidationRowWidget extends StatelessWidget {
  final String text;
  bool checked;
  ValidationRowWidget({super.key, required this.text, this.checked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: fixDpiHeight(4)),
      // height: 33.h,
      child: Row(
        children: [
          SizedBox(
              width: fixDpiWidth(16),
              height: fixDpiHeight(16),
              child: Image.asset(
                AppImages.checkIcon,
                color: checked ? Styles.green : Styles.disabledGreyColor,
              )),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: fixDpiFont(15),
                fontWeight: FontWeight.w400,
                color: checked ? Styles.green : Styles.disabledGreyColor,
                fontFamily: "baloo"),
          ),
        ],
      ),
    );
  }
}
