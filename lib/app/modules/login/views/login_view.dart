import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_container.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 48.h, right: 16.w, left: 16.w),
            height: fixDpiScreenHeight(),
            width: fixDpiScreenWidth(),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/travel.png',
                  width: 56.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 16.h,
                ),
                TitleText(title: AppStrings.logIn.tr),
                SizedBox(
                  height: 40.h,
                ),
                TextFieldTitle(title: AppStrings.nationalID.tr),
                TextFieldContainer(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    // controller: _mobileController,
                    textDirection: TextDirection.ltr,
                    scrollPadding: const EdgeInsets.only(bottom: 120),
                    // validator: (val) =>
                    //     Validators.validateMobilePhone(val, context),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) {},
                    maxLength: 14,
                    onFieldSubmitted: (val) {},
                    textAlign: LocalizationHelper.isArabic()
                        ? TextAlign.right
                        : TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: Styles().inputDecoration.copyWith(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                    textInputAction: TextInputAction.go,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFieldTitle(title: AppStrings.password.tr),
                TextFieldContainer(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    // controller: _mobileController,
                    textDirection: TextDirection.ltr,
                    scrollPadding: const EdgeInsets.only(bottom: 120),
                    // validator: (val) =>
                    //     Validators.validateMobilePhone(val, context),
                    keyboardType: TextInputType.text,
                    obscureText: true,

                    onChanged: (val) {},

                    onFieldSubmitted: (val) {},
                    textAlign: LocalizationHelper.isArabic()
                        ? TextAlign.right
                        : TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: Styles().inputDecoration.copyWith(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                    textInputAction: TextInputAction.go,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        AppStrings.forgetPassword.tr,
                        style: const TextStyle(
                          color: Styles.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 220.h,
                ),
                CustomButton(
                  text: AppStrings.logIn.tr,
                  icon: Icons.arrow_forward,
                  type: ButtonType.primary,
                  width: 300.w,
                  height: 50,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.donotHaveAccount.tr,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Styles.lightBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.REGISTRATION,
                        );
                      },
                      child: Text(
                        AppStrings.newAccount.tr,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Styles.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
