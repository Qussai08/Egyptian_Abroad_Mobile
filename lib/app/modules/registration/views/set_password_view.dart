import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/validation_rule_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class SetPasswordView extends StatefulWidget {
  const SetPasswordView({super.key});

  @override
  State<SetPasswordView> createState() => _SetPasswordViewState();
}

class _SetPasswordViewState extends State<SetPasswordView>
    with ValidationMixin {
  final TextEditingController _confirmPassTxtController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(RegistrationController());

  final ValueNotifier<List<bool>> _validationsValues =
      ValueNotifier([false, false, false, false]);

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
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
                      AppImages.lock,
                      width: 56.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TitleText(title: AppStrings.setPasswordTitle.tr),
                    SizedBox(
                      height: 40.h,
                    ),
                    TextFieldTitle(title: AppStrings.password.tr),
                    CustomTextFormField(
                      controller: controller.passwordTxtController,
                      validationFunc: (val) {
                        return controller.passwordTxtController.text
                                .trim()
                                .isEmpty
                            ? AppStrings.emptyValidation.tr
                            : _validationsValues.value.firstWhereOrNull(
                                        (element) => element == false) !=
                                    null
                                ? AppStrings.passwordWeekValidation.tr
                                : validatePassword(
                                    controller.passwordTxtController.text);
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(title: AppStrings.confirmPassword.tr),
                    CustomTextFormField(
                      controller: _confirmPassTxtController,
                      validationFunc: (val) =>
                          _confirmPassTxtController.text.trim().isEmpty
                              ? AppStrings.emptyValidation.tr
                              : validateConfirmPassword(
                                  _confirmPassTxtController.text,
                                  controller.passwordTxtController.text),
                      inputData: TextInputType.text,
                      isPassword: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                  text:
                                      AppStrings.passwordContainsSpecialChar.tr,
                                  checked: validations[3],
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 90.h,
                    ),
                    CustomButton(
                      text: AppStrings.register.tr,
                      // icon: Icons.arrow_forward,
                      type: ButtonType.primary,
                      width: 300.w,
                      height: 50,
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _validationsValues.value.firstWhereOrNull(
                                    (element) => element == false) ==
                                null) {
                          await controller.register();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
