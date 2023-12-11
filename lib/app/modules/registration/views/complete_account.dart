import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class CompleteAccountView extends StatefulWidget {
  const CompleteAccountView({Key? key}) : super(key: key);

  @override
  State<CompleteAccountView> createState() => _CompleteAccountViewState();
}

class _CompleteAccountViewState extends State<CompleteAccountView>
    with ValidationMixin {
  final TextEditingController _egPassportNumTxtController =
      TextEditingController();
  final ValueNotifier<String> _residenceCountry = ValueNotifier('الامارات');
  final ValueNotifier<String> _residenceType = ValueNotifier('اختيار ١');
  final TextEditingController _residenceNumTxtController =
      TextEditingController();
  final TextEditingController _forignPassportNumTxtController =
      TextEditingController();
  final TextEditingController _residenceAddressTxtController =
      TextEditingController();
  final ValueNotifier<String> _jobCategory = ValueNotifier('اختيار ١');

  final TextEditingController _jobTitleTxtController = TextEditingController();
  final TextEditingController _egptionPhoneNumTxtController =
      TextEditingController();
  final TextEditingController _forignPhoneNumTxtController =
      TextEditingController();
  final TextEditingController _msgsAddressTxtController =
      TextEditingController();

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
                    TitleText(title: AppStrings.completeAccountTitle.tr),
                    SizedBox(
                      height: 32.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.egPassportNum.tr, hasSubTitle: false),
                    CustomTextFormField(
                      controller: _egPassportNumTxtController,
                      validationFunc: (val) {
                        // validateName(_nameTxtController.text)
                      },
                      inputData: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.residence.tr, hasSubTitle: false),
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
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.residenceType.tr, hasSubTitle: false),
                    ValueListenableBuilder<String>(
                        valueListenable: _residenceType,
                        builder: (_, residenceTP, __) {
                          return DropDownListSelector(
                            dropDownList: const <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: 'اختيار ١',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ١'),
                              ),
                              DropdownMenuItem(
                                value: 'اختيار ٢',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ٢'),
                              ),
                              DropdownMenuItem(
                                value: 'اختيار ٣',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ٣'),
                              ),
                            ],
                            value: residenceTP,
                            hint: "",
                            onChangeFunc: (val) {
                              _residenceType.value = val;
                            },
                          );
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.residenceNumber.tr,
                        hasSubTitle: false),
                    CustomTextFormField(
                      controller: _residenceNumTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.forignPassportNum.tr,
                        hasSubTitle: false),
                    CustomTextFormField(
                      controller: _forignPassportNumTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.residenceAddress.tr,
                        hasSubTitle: false),
                    CustomTextFormField(
                      controller: _residenceAddressTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.jobCategory.tr, hasSubTitle: false),
                    ValueListenableBuilder<String>(
                        valueListenable: _jobCategory,
                        builder: (_, category, __) {
                          return DropDownListSelector(
                            dropDownList: const <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: 'اختيار ١',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ١'),
                              ),
                              DropdownMenuItem(
                                value: 'اختيار ٢',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ٢'),
                              ),
                              DropdownMenuItem(
                                value: 'اختيار ٣',
                                alignment: Alignment.centerRight,
                                child: Text('اختيار ٣'),
                              ),
                            ],
                            value: category,
                            hint: "",
                            onChangeFunc: (val) {
                              _jobCategory.value = val;
                            },
                          );
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.jobTitle.tr, hasSubTitle: false),
                    CustomTextFormField(
                      controller: _jobTitleTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: 100,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                      title: AppStrings.egPhoneNum.tr,
                      hasSubTitle: false,
                    ),
                    CustomTextFormField(
                      controller: _egptionPhoneNumTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        TextFieldTitle(
                            title: AppStrings.forignPhoneNum.tr,
                            hasSubTitle: false,
                            hasHorizontalMargin: false),
                        TextFieldTitle(
                          title: AppStrings.forignPhoneNumHint.tr,
                          fontSize: 10,
                          hasSubTitle: false,
                          hasHorizontalMargin: false,
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      controller: _forignPhoneNumTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.phone,
                      maxLength: null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.msgsAddress.tr, hasSubTitle: false),
                    CustomTextFormField(
                      controller: _msgsAddressTxtController,
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: null,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      text: AppStrings.save.tr,
                      // icon: Icons.arrow_forward,
                      type: ButtonType.primary,
                      width: 300.w,
                      height: 50,

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.offAllNamed(Routes.BOTTOMNAVIGATION);
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomButton(
                      text: AppStrings.skip.tr,
                      type: ButtonType.secondary,
                      width: 300.w,
                      height: 50,
                      onPressed: () {
                        Get.offAllNamed(Routes.BOTTOMNAVIGATION);
                      },
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
