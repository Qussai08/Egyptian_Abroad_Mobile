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

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            height: fixDpiScreenHeight(),
            width: fixDpiScreenWidth(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 48.h,
                  ),
                  Image.asset(
                    'assets/images/user.png',
                    width: 56.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TitleText(title: AppStrings.register.tr),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextFieldTitle(title: AppStrings.name.tr),
                  TextFieldContainer(
                    width: double.infinity,
                    height: 50,
                    borderColor: const Color(0xffEBEBEB),
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      scrollPadding: const EdgeInsets.only(bottom: 120),
                      keyboardType: TextInputType.text,
                      onChanged: (val) {},
                      maxLength: 14,
                      onFieldSubmitted: (val) {},
                      textAlign: LocalizationHelper.isArabic()
                          ? TextAlign.right
                          : TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'baloo'),
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
                  TextFieldTitle(title: AppStrings.nationalID.tr),
                  TextFieldContainer(
                    borderColor: const Color(0xffEBEBEB),
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      scrollPadding: const EdgeInsets.only(bottom: 120),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {},
                      maxLength: 14,
                      onFieldSubmitted: (val) {},
                      textAlign: LocalizationHelper.isArabic()
                          ? TextAlign.right
                          : TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'baloo'),
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
                  TextFieldTitle(title: AppStrings.email.tr),
                  TextFieldContainer(
                    borderColor: const Color(0xffEBEBEB),
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      scrollPadding: const EdgeInsets.only(bottom: 120),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {},
                      maxLength: 14,
                      onFieldSubmitted: (val) {},
                      textAlign: LocalizationHelper.isArabic()
                          ? TextAlign.right
                          : TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'baloo'),
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
                  TextFieldTitle(title: AppStrings.residence.tr),
                  TextFieldContainer(
                    borderColor: const Color(0xffEBEBEB),
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      scrollPadding: const EdgeInsets.only(bottom: 120),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {},
                      maxLength: 14,
                      onFieldSubmitted: (val) {},
                      textAlign: LocalizationHelper.isArabic()
                          ? TextAlign.right
                          : TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'baloo'),
                      decoration: Styles().inputDecoration,
                      textInputAction: TextInputAction.go,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomButton(
                    text: AppStrings.next.tr,
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 300.w,
                    height: 50,
                    onPressed: () {
                      Get.toNamed(
                        Routes.OTP,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount.tr,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Styles.lightBlack,
                            fontFamily: 'baloo'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.LOGIN,
                          );
                        },
                        child: Text(
                          AppStrings.logIn.tr,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Styles.primaryColor,
                              decoration: TextDecoration.underline,
                              fontFamily: 'baloo'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
