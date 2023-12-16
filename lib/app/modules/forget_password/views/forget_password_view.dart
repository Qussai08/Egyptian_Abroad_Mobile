import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_images.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView>
    with ValidationMixin {
  final TextEditingController _emailTxtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());

    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          body: Container(
            padding: EdgeInsets.only(top: 30.h, right: 16.w, left: 16.w),
            height: fixDpiScreenHeight(),
            width: fixDpiScreenWidth(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    // TODO: use reference from AppImages
                    AppImages.forgetPassword,
                    width: 56.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TitleText(title: AppStrings.forgetPasswordTitle.tr),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextFieldTitle(title: AppStrings.email.tr),
                  CustomTextFormField(
                    controller: _emailTxtController,
                    validationFunc: (val) =>
                        validateUserEmail(_emailTxtController.text),
                    inputData: TextInputType.emailAddress,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: AppStrings.sendVerificationCode.tr,
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 300.w,
                    height: 50,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                    },
                  ),
                  SizedBox(
                    height: 35.h,
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
