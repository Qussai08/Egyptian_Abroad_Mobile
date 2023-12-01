import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
          body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 48.h, right: 16.w, left: 16.w),
          height: fixDpiScreenHeight(),
          width: fixDpiScreenWidth(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Image.asset(
                  'assets/images/Fingerprint.png',
                  width: 228.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 15.h,
                ),
                TitleText(title: AppStrings.otpTitle.tr),
                SizedBox(
                  height: 15.h,
                ),
                TitleText(
                  title: AppStrings.otpDiscription.tr,
                  titleTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Styles.lightBlack,
                      fontFamily: 'baloo'),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    otpFieldStyle:
                        OtpFieldStyle(focusBorderColor: Styles.primaryColor),
                    fieldWidth: 50,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    keyboardType: TextInputType.number,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (pin) {},
                    onCompleted: (pin) async {},
                  ),
                ),

                ///

                // TODO : add resend in widget
              ],
            ),
          ),
        ),
      )),
    );
  }
}
