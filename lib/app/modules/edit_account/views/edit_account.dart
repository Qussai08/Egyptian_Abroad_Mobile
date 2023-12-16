import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
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
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class EditAccountView extends StatefulWidget {
  final bool? isEdit;
  const EditAccountView({super.key, this.isEdit = true});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView>
    with ValidationMixin {
  final TextEditingController _nameTxtController = TextEditingController();
  final TextEditingController _nationalIDTxtController =
      TextEditingController();
  final TextEditingController _emailTxtController = TextEditingController();
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
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.h,
                    ),
                    Image.asset(
                      AppImages.user,
                      width: 56.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TitleText(
                        title: widget.isEdit!
                            ? AppStrings.editAccountInfos.tr
                            : AppStrings.accountInfos.tr),
                    SizedBox(
                      height: 40.h,
                    ),
                    TextFieldTitle(
                      title: AppStrings.name.tr,
                      hasSubTitle: false,
                    ),
                    CustomTextFormField(
                      validationFunc: (val) =>
                          validateName(_nameTxtController.text),
                      inputData: TextInputType.text,
                      enabled: widget.isEdit,
                      controller: widget.isEdit! ? _nameTxtController : null,
                      initialValue: widget.isEdit! ? null : AppStrings.name.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.nationalID.tr, hasSubTitle: false),
                    CustomTextFormField(
                      validationFunc: (val) =>
                          validateNationalID(_nationalIDTxtController.text),
                      inputData: TextInputType.number,
                      maxLength: null,
                      fillColor: const Color(0xffF8F8F8),
                      enabled: false,
                      controller:
                          widget.isEdit! ? _nationalIDTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.nationalID.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                      title: AppStrings.email.tr,
                      hasSubTitle: false,
                    ),
                    CustomTextFormField(
                      validationFunc: (val) =>
                          validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.emailAddress,
                      fillColor: const Color(0xffF8F8F8),
                      enabled: false,
                      controller: widget.isEdit! ? _emailTxtController : null,
                      initialValue: widget.isEdit! ? null : AppStrings.email.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.egPassportNum.tr, hasSubTitle: false),
                    CustomTextFormField(
                      validationFunc: (val) {
                        return null;

                        // validateName(_nameTxtController.text)
                      },
                      inputData: TextInputType.text,
                      enabled: false,
                      controller:
                          widget.isEdit! ? _egPassportNumTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.egPassportNum.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                      title: AppStrings.residence.tr,
                      hasSubTitle: false,
                    ),
                    ValueListenableBuilder<String>(
                        valueListenable: _residenceCountry,
                        builder: (_, residence, __) {
                          return DropDownListSelector(
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                            dropDownList: widget.isEdit!
                                ? const <DropdownMenuItem>[
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
                                  ]
                                : [],
                            value: residence,
                            hint: residence,
                            blackHint: true,
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
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                            dropDownList: widget.isEdit!
                                ? const <DropdownMenuItem>[
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
                                  ]
                                : [],
                            value: residenceTP,
                            hint: residenceTP,
                            blackHint: true,
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
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      enabled: widget.isEdit,
                      controller:
                          widget.isEdit! ? _residenceNumTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.residenceNumber.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.forignPassportNum.tr,
                        hasSubTitle: false),
                    CustomTextFormField(
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      enabled: widget.isEdit,
                      controller: widget.isEdit!
                          ? _forignPassportNumTxtController
                          : null,
                      initialValue: widget.isEdit!
                          ? null
                          : AppStrings.forignPassportNum.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //-------------------
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.residenceAddress.tr,
                        hasSubTitle: false),
                    CustomTextFormField(
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: null,
                      enabled: widget.isEdit,
                      controller: widget.isEdit!
                          ? _residenceAddressTxtController
                          : null,
                      initialValue: widget.isEdit!
                          ? null
                          : AppStrings.residenceAddress.tr,
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
                            dropDownList: widget.isEdit!
                                ? const <DropdownMenuItem>[
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
                                  ]
                                : [],
                            value: category,
                            hint: category,
                            blackHint: true,
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
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
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: null,
                      enabled: widget.isEdit,
                      controller:
                          widget.isEdit! ? _jobTitleTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.jobTitle.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                      title: AppStrings.egPhoneNum.tr,
                      hasSubTitle: false,
                    ),
                    CustomTextFormField(
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.phone,
                      maxLength: null,
                      enabled: widget.isEdit,
                      controller:
                          widget.isEdit! ? _egptionPhoneNumTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.egPhoneNum.tr,
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
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.phone,
                      maxLength: null,
                      enabled: widget.isEdit,
                      controller:
                          widget.isEdit! ? _forignPhoneNumTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.forignPhoneNum.tr,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(
                        title: AppStrings.msgsAddress.tr, hasSubTitle: false),
                    CustomTextFormField(
                      // validationFunc: (val) =>
                      //     validateUserEmail(_emailTxtController.text),
                      inputData: TextInputType.text,
                      maxLength: null,
                      enabled: widget.isEdit,
                      controller:
                          widget.isEdit! ? _msgsAddressTxtController : null,
                      initialValue:
                          widget.isEdit! ? null : AppStrings.msgsAddress.tr,
                    ),
                    //------------------
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
                                    fontSize: fixDpiFont(12))
                                .copyWith(decoration: TextDecoration.underline),
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
