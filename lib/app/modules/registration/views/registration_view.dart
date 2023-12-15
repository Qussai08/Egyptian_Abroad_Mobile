import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return NetworkIndicator(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: GetBuilder<RegistrationController>(
                  builder: (registrationController) => registrationController
                          .countriesLoading
                      ? Container(
                          height: fixDpiScreenHeight(),
                          width: fixDpiScreenWidth(),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Styles.primaryColor,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 48.h,
                            ),
                            Image.asset(
                              AppImages.user,
                              width: 56.w,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TitleText(title: AppStrings.registerNew.tr),
                            SizedBox(
                              height: 40.h,
                            ),
                            TextFieldTitle(title: AppStrings.name.tr),
                            CustomTextFormField(
                              controller: controller.nameTxtController,
                              validationFunc: (val) => validateName(
                                  controller.nameTxtController.text),
                              inputData: TextInputType.text,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(title: AppStrings.nationalID.tr),
                            CustomTextFormField(
                              controller: controller.nationalIDTxtController,
                              validationFunc: (val) => validateNationalID(
                                  controller.nationalIDTxtController.text),
                              inputData: TextInputType.number,
                              maxLength: null,
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            TextFieldTitle(title: AppStrings.email.tr),
                            CustomTextFormField(
                              controller: controller.emailTxtController,
                              validationFunc: (val) => validateUserEmail(
                                  controller.emailTxtController.text),
                              inputData: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(title: AppStrings.residence.tr),
                            ValueListenableBuilder<int>(
                                valueListenable: controller.residenceCountry,
                                builder: (_, residence, __) {
                                  return DropDownListSelector(
                                    dropDownList:
                                        (controller.countriesList.length == 0)
                                            ? <DropdownMenuItem>[]
                                            : controller.countriesList
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e.country),
                                                      value: e.id,
                                                    ))
                                                .toList(),
                                    value: residence,
                                    hint: "",
                                    onChangeFunc: (val) {
                                      controller.residenceCountry.value = val;
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 50.h,
                            ),
                            CustomButton(
                              text: AppStrings.next.tr,
                              icon: Icons.arrow_forward,
                              type: ButtonType.primary,
                              width: 300.w,
                              height: 50,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.createVerificationCode();
                                  Get.toNamed(
                                    Routes.OTP,
                                  );
                                }
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
                                  style: Styles.getRegularStyle(
                                      color: Styles.lightBlack,
                                      fontSize: fixDpiFont(11)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    AppStrings.logIn.tr,
                                    style: Styles.getSemiBoldStyle(
                                        color: Styles.primaryColor,
                                        fontSize: fixDpiFont(12)),
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
        ),
      ),
    );
  }
}
