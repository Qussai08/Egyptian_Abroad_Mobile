import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/validation_rule_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/change_password/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<List<bool>> _validationsValues =
      ValueNotifier([false, false, false, false]);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return NetworkIndicator(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: ListView(
            children: [
              // Title and Image
              Column(
                children: [
                  Image.asset(
                    AppImages.forgetPassword,
                    width: 56.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TitleText(title: AppStrings.changePassword.tr),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                height: fixDpiScreenHeight(),
                width: fixDpiScreenWidth(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      TextFieldTitle(title: AppStrings.oldPassword.tr),
                      CustomTextFormField(
                        maxLength: 100,
                        controller: controller.oldPasswordTxtController,
                        validationFunc: (val) => validateOldPassword(
                            controller.oldPasswordTxtController.text),
                        inputData: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFieldTitle(title: AppStrings.newPassword.tr),
                      CustomTextFormField(
                        maxLength: 100,
                        controller: controller.newPasswordTxtController,
                        validationFunc: (val) {
                          return validatePassword(controller
                                      .newPasswordTxtController.text) ==
                                  null
                              ? _validationsValues.value.firstWhereOrNull(
                                          (element) => element == false) !=
                                      null
                                  ? AppStrings.passwordWeekValidation.tr
                                  : null
                              : null;
                        },
                        onChangedFunc: (val) {
                          _validationsValues.value = [
                            passMinimumLenght(val),
                            atLeastOneCharString(val),
                            atLeastOneNumberString(val),
                            atLeastOneSpecialCharString(val)
                          ];
                        },
                        inputData: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFieldTitle(title: AppStrings.confirmNewPassword.tr),
                      CustomTextFormField(
                        maxLength: 100,
                        controller: controller.confirmNewPasswordTxtController,
                        validationFunc: (val) => validateConfirmPassword(
                            controller.confirmNewPasswordTxtController.text,
                            controller.newPasswordTxtController.text),
                        inputData: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      ValueListenableBuilder<dynamic>(
                          valueListenable: _validationsValues,
                          builder: (_, validations, __) {
                            return SizedBox(
                              // height: 140.h,
                              child: Column(
                                children: [
                                  ValidationRowWidget(
                                    text: AppStrings.passwordMinimum.tr,
                                    checked: validations[0],
                                  ),
                                  ValidationRowWidget(
                                    text: AppStrings.passwordContainsChar.tr,
                                    checked: validations[1],
                                  ),
                                  ValidationRowWidget(
                                    text: AppStrings.passwordContainsNum.tr,
                                    checked: validations[2],
                                  ),
                                  ValidationRowWidget(
                                    text: AppStrings
                                        .passwordContainsSpecialChar.tr,
                                    checked: validations[3],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButton(
                        text: AppStrings.confirm.tr,
                        type: ButtonType.primary,
                        width: 300.w,
                        height: 50.h,
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _validationsValues.value.firstWhereOrNull(
                                      (element) => element == false) ==
                                  null) {
                            await controller.changePassword(
                                oldPassword:
                                    controller.oldPasswordTxtController.text,
                                newPassword:
                                    controller.newPasswordTxtController.text);
                          }
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: AppStrings.cancel.tr,
                        type: ButtonType.secondary,
                        width: 300.w,
                        height: 50.h,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
