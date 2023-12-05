import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
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
  final TextEditingController _nameTxtController = TextEditingController();
  final TextEditingController _nationalIDTxtController =
      TextEditingController();
  final TextEditingController _emailTxtController = TextEditingController();
  final ValueNotifier<String> _residenceCountry = ValueNotifier('الامارات');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                    TitleText(title: AppStrings.registerNew.tr),
                    SizedBox(
                      height: 40.h,
                    ),
                    TextFieldTitle(title: AppStrings.name.tr),
                    CustomTextFormField(
                      controller: _nameTxtController,
                      validationFunc: (val) =>
                          validateName(_nameTxtController.text),
                      inputData: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(title: AppStrings.nationalID.tr),
                    CustomTextFormField(
                      controller: _nationalIDTxtController,
                      validationFunc: (val) =>
                          validateNationalID(_nationalIDTxtController.text),
                      inputData: TextInputType.number,
                      maxLength: 14,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFieldTitle(title: AppStrings.email.tr),
                    CustomTextFormField(
                      controller: _emailTxtController,
                      validationFunc: (val) =>
                          validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(title: AppStrings.residence.tr),
                    ValueListenableBuilder<String>(
                        valueListenable: _residenceCountry,
                        builder: (_, residence, __) {
                          return DropDownListSelector(
                            dropDownList: const <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: 'الامارات',
                                alignment: Alignment.centerRight,
                                child: Text('الامارات'),
                              ),
                              DropdownMenuItem(
                                value: 'الكويت',
                                alignment: Alignment.centerRight,
                                child: Text('الكويت'),
                              ),
                              DropdownMenuItem(
                                value: 'السعودية',
                                alignment: Alignment.centerRight,
                                child: Text('السعودية'),
                              ),
                            ],
                            value: residence,
                            hint: "",
                            onChangeFunc: (val) {
                              _residenceCountry.value = val;
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Styles.lightBlack,
                              fontFamily: 'baloo'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
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
      ),
    );
  }
}
