import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/models/user_profile.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
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
  bool intialRun = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (intialRun) {
      var controller = Get.put(RegistrationController());
      controller.loadResidenceData();
      intialRun = false;
    }
  }

  final TextEditingController _nameTxtController =
      TextEditingController(text: AppHelper.userProfile!.name);
  final TextEditingController _nationalIDTxtController =
      TextEditingController(text: AppHelper.userProfile!.nationalId);
  final TextEditingController _emailTxtController =
      TextEditingController(text: AppHelper.userProfile!.email);
  final TextEditingController _egPassportNumTxtController =
      TextEditingController(text: AppHelper.userProfile!.passportNo);

  final ValueNotifier<int?> _residenceCountry =
      ValueNotifier(AppHelper.userProfile!.residencyCountryId);
  final ValueNotifier<int?> _residenceType =
      ValueNotifier(AppHelper.userProfile!.residencyTypeId);
  final TextEditingController _residenceNumTxtController =
      TextEditingController(text: AppHelper.userProfile!.residencyNo);
  final TextEditingController _forignPassportNumTxtController =
      TextEditingController(text: AppHelper.userProfile!.foreignPassportNo);

  final TextEditingController _residenceAddressTxtController =
      TextEditingController(text: AppHelper.userProfile!.residencyAddress);
  final ValueNotifier<int?> _jobCategory =
      ValueNotifier(AppHelper.userProfile!.jobCategoryID);

  final TextEditingController _jobTitleTxtController =
      TextEditingController(text: AppHelper.userProfile!.jobTitle);
  final TextEditingController _egptionPhoneNumTxtController =
      TextEditingController(text: AppHelper.userProfile!.egyptionMobile);
  final TextEditingController _forignPhoneNumTxtController =
      TextEditingController(text: AppHelper.userProfile!.foreignMobile);
  final TextEditingController _msgsAddressTxtController =
      TextEditingController(text: AppHelper.userProfile!.messagingAddress);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: GetBuilder<RegistrationController>(
                builder: (controller) => Form(
                  key: _formKey,
                  child: controller.residenceLoading
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
                              height: 12.h,
                            ),
                            Image.asset(
                              'assets/images/user.png',
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
                              controller: _nameTxtController,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                                title: AppStrings.nationalID.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                              inputData: TextInputType.number,
                              maxLength: null,
                              fillColor: Color(0xffF8F8F8),
                              enabled: false,
                              controller: _nationalIDTxtController,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                              title: AppStrings.email.tr,
                              hasSubTitle: false,
                            ),
                            CustomTextFormField(
                              inputData: TextInputType.emailAddress,
                              fillColor: Color(0xffF8F8F8),
                              enabled: false,
                              controller: _emailTxtController,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                                title: AppStrings.egPassportNum.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                              validationFunc: (val) => validateEgyptionPassport(
                                  _egPassportNumTxtController.text),
                              inputData: TextInputType.text,
                              enabled: false,
                              controller: _egPassportNumTxtController,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                              title: AppStrings.residence.tr,
                              hasSubTitle: false,
                            ),
                            ValueListenableBuilder<int?>(
                                valueListenable: _residenceCountry,
                                builder: (_, residence, __) {
                                  return DropDownListSelector(
                                    hintFontSize: 14,
                                    hintFontWeight: FontWeight.w400,
                                    dropDownList: widget.isEdit!
                                        ? controller.countriesList
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(e.country),
                                                  value: e.id,
                                                ))
                                            .toList()
                                        : [],
                                    value: residence,
                                    hint: !widget.isEdit!
                                        ? controller.countriesList
                                            .firstWhereOrNull((element) =>
                                                element.id == residence)!
                                            .country
                                        : "",
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
                                title: AppStrings.residenceType.tr,
                                hasSubTitle: false),
                            ValueListenableBuilder<int?>(
                                valueListenable: _residenceType,
                                builder: (_, residenceTP, __) {
                                  return Column(
                                    children: [
                                      DropDownListSelector(
                                        hintFontSize: 14,
                                        hintFontWeight: FontWeight.w400,
                                        dropDownList: widget.isEdit!
                                            ? controller.residenceTypeList
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e.name),
                                                      value: e.id,
                                                    ))
                                                .toList()
                                            : [],
                                        value: residenceTP,
                                        hint: !widget.isEdit!
                                            ? controller.residenceTypeList
                                                        .firstWhereOrNull(
                                                            (element) =>
                                                                element.id ==
                                                                residenceTP) !=
                                                    null
                                                ? controller.residenceTypeList
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element.id ==
                                                            residenceTP)!
                                                    .name
                                                : ""
                                            : "",
                                        blackHint: true,
                                        onChangeFunc: (val) {
                                          _residenceType.value = val;
                                        },
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      if (residenceTP == 1)
                                        TextFieldTitle(
                                            title:
                                                AppStrings.residenceNumber.tr,
                                            hasSubTitle: false),
                                      if (residenceTP == 1)
                                        CustomTextFormField(
                                          enabled: widget.isEdit,
                                          controller:
                                              _residenceNumTxtController,
                                          inputData: TextInputType.text,
                                          validationFunc: (val) =>
                                              maxLenghtValidation(
                                                  _residenceNumTxtController
                                                      .text,
                                                  20),
                                        ),
                                      if (residenceTP == 1)
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                      if (residenceTP == 2)
                                        TextFieldTitle(
                                            title:
                                                AppStrings.forignPassportNum.tr,
                                            hasSubTitle: false),
                                      if (residenceTP == 2)
                                        CustomTextFormField(
                                          enabled: widget.isEdit,
                                          controller:
                                              _forignPassportNumTxtController,
                                          inputData: TextInputType.text,
                                          validationFunc: (val) =>
                                              maxLenghtValidation(
                                                  _forignPassportNumTxtController
                                                      .text,
                                                  20),
                                        ),
                                      if (residenceTP == 2)
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                    ],
                                  );
                                }),

                            TextFieldTitle(
                                title: AppStrings.residenceAddress.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                                inputData: TextInputType.text,
                                maxLength: null,
                                enabled: widget.isEdit,
                                controller: _residenceAddressTxtController),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                                title: AppStrings.jobCategory.tr,
                                hasSubTitle: false),
                            ValueListenableBuilder<int?>(
                                valueListenable: _jobCategory,
                                builder: (_, category, __) {
                                  return DropDownListSelector(
                                    dropDownList: widget.isEdit!
                                        ? controller.jobCategoryList
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(e.name),
                                                  value: e.id,
                                                ))
                                            .toList()
                                        : [],
                                    value: category,
                                    hint: !widget.isEdit!
                                        ? controller.jobCategoryList
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element.id ==
                                                            category) !=
                                                null
                                            ? controller.jobCategoryList
                                                .firstWhereOrNull((element) =>
                                                    element.id == category)!
                                                .name
                                            : ""
                                        : "",
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
                                title: AppStrings.jobTitle.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                              inputData: TextInputType.text,
                              maxLength: null,
                              enabled: widget.isEdit,
                              controller: _jobTitleTxtController,
                              validationFunc: (val) => maxLenghtValidation(
                                  _jobTitleTxtController.text, 100),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                              title: AppStrings.egPhoneNum.tr,
                              hasSubTitle: false,
                            ),
                            CustomTextFormField(
                              inputData: TextInputType.phone,
                              maxLength: null,
                              enabled: widget.isEdit,
                              controller: _egptionPhoneNumTxtController,
                              validationFunc: (val) => validateEgyptionPhoneNum(
                                  _egptionPhoneNumTxtController.text),
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
                              validationFunc: (val) => maxLenghtValidation(
                                  _forignPhoneNumTxtController.text, 15),
                              inputData: TextInputType.phone,
                              maxLength: null,
                              enabled: widget.isEdit,
                              controller: _forignPhoneNumTxtController,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                                title: AppStrings.msgsAddress.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                              inputData: TextInputType.text,
                              maxLength: null,
                              enabled: widget.isEdit,
                              controller: _msgsAddressTxtController,
                            ),
                            //------------------
                            SizedBox(
                              height: 32.h,
                            ),
                            CustomButton(
                              // TODO : translate
                              text: "حفظ",
                              type: widget.isEdit!
                                  ? ButtonType.primary
                                  : ButtonType.disabled,
                              width: 300.w,
                              height: 50,
                              onPressed: () async {
                                if (widget.isEdit! &&
                                    _formKey.currentState!.validate()) {
                                  await controller.editAccount(UserProfile(
                                      name: _nameTxtController.text,
                                      residencyCountryId:
                                          _residenceCountry.value,
                                      residencyTypeId: _residenceType.value,
                                      residencyNo:
                                          _residenceNumTxtController.text,
                                      foreignPassportNo:
                                          _forignPassportNumTxtController.text,
                                      residencyAddress:
                                          _residenceAddressTxtController.text,
                                      jobTitle: _jobTitleTxtController.text,
                                      egyptionMobile:
                                          _egptionPhoneNumTxtController.text,
                                      foreignMobile:
                                          _forignPhoneNumTxtController.text,
                                      messagingAddress:
                                          _msgsAddressTxtController.text,
                                      passportNo:
                                          _egPassportNumTxtController.text));
                                }
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),

                            CustomButton(
                              // TODO : translate
                              text: "الغاء",
                              type: ButtonType.secondary,
                              width: 300.w,
                              height: 50,
                              onPressed: () {
                                Get.back();
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
      ),
    );
  }
}
