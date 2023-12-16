import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_container.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/validation_rule_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:egyptians_abroad/app/modules/login/controllers/login_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgetPassSetPasswordView extends StatefulWidget {
  const ForgetPassSetPasswordView({super.key});

  @override
  State<ForgetPassSetPasswordView> createState() =>
      _ForgetPassSetPasswordViewState();
}

class _ForgetPassSetPasswordViewState extends State<ForgetPassSetPasswordView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<List<bool>> _validationsValues =
      ValueNotifier([false, false, false, false]);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return NetworkIndicator(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 48.h, right: 16.w, left: 16.w),
            height: fixDpiScreenHeight(),
            width: fixDpiScreenWidth(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/lock.png',
                    width: 56.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  // TODO : translate
                  TitleText(title: "تعيين كلمة مرور جديدة"),
                  SizedBox(
                    height: 40.h,
                  ),
                  // TODO : translate
                  TextFieldTitle(title: "كلمة المرور الجديدة"),
                  CustomTextFormField(
                    controller: controller.newPasswordTxtController,
                    validationFunc: (val) {
                      return _validationsValues.value.firstWhereOrNull(
                                  (element) => element == false) !=
                              null
                          ? AppStrings.passwordWeekValidation.tr
                          : validatePassword(
                              controller.newPasswordTxtController.text);
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
                  // TODO : translate
                  TextFieldTitle(title: "تأكيد كلمة المرور الجديدة"),
                  CustomTextFormField(
                    controller: controller.confirmNewPassTxtController,
                    validationFunc: (val) => controller
                            .confirmNewPassTxtController.text
                            .trim()
                            .isEmpty
                        ? AppStrings.emptyValidation.tr
                        : _validationsValues.value.firstWhereOrNull(
                                    (element) => element == false) !=
                                null
                            ? AppStrings.passwordWeekValidation.tr
                            : validateConfirmPassword(
                                controller.confirmNewPassTxtController.text),
                    inputData: TextInputType.text,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ValueListenableBuilder<dynamic>(
                      valueListenable: _validationsValues,
                      builder: (_, validations, __) {
                        return SizedBox(
                          height: 140.h,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
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
                                text: AppStrings.passwordContainsSpecialChar.tr,
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
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 300.w,
                    height: 50,
                    onPressed: () async {
                      print(_validationsValues.value);
                      if (_formKey.currentState!.validate() &&
                          _validationsValues.value.firstWhereOrNull(
                                  (element) => element == false) ==
                              null) {
                        await controller.forgetPass();
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    // TODO : translate
                    text: "الغاء",
                    icon: Icons.arrow_forward,

                    type: ButtonType.secondary,
                    width: 300.w,
                    height: 50,
                    onPressed: () {
                      Get.offAll(Routes.LOGIN);
                    },
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
