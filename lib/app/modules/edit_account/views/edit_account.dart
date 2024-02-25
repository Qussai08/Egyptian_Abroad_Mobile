import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/selector_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/user_profile.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'widgets/jobCategorySelector.dart';

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
      var controller = Get.find<RegistrationController>();
      controller.residenceDataLoading = true;
      controller.loadResidenceData();
      intialRun = false;
    }
  }

  final TextEditingController _nameTxtController =
      TextEditingController(text: AuthService().getUserProfile.name ?? "");
  final TextEditingController _nationalIDTxtController = TextEditingController(
      text: AuthService().getUserProfile.nationalId ?? "");
  final TextEditingController _emailTxtController =
      TextEditingController(text: AuthService().getUserProfile.email ?? "");
  final TextEditingController _egPassportNumTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.passportNo ?? "");

  final ValueNotifier<int?> _residenceCountry =
      ValueNotifier(AuthService().getUserProfile.residencyCountryId);
  final ValueNotifier<int?> _residenceType =
      ValueNotifier(AuthService().getUserProfile.residencyTypeId);
  final TextEditingController _residenceNumTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.residencyNo ?? "");
  final TextEditingController _forignPassportNumTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.foreignPassportNo ?? "");

  final TextEditingController _residenceAddressTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.residencyAddress ?? "");
  final ValueNotifier<int?> _jobCategory =
      ValueNotifier(AuthService().getUserProfile.jobCategoryID);

  final TextEditingController _jobTitleTxtController =
      TextEditingController(text: AuthService().getUserProfile.jobTitle ?? "");
  final TextEditingController _egptionPhoneNumTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.egyptionMobile ?? "");
  final TextEditingController _forignPhoneNumTxtController =
      TextEditingController(
          text: AuthService().getUserProfile.foreignMobile ?? "");
  final TextEditingController _msgsAddressTxtController = TextEditingController(
      text: AuthService().getUserProfile.messagingAddress ?? "");

  FocusNode jobCatSearchFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          resizeToAvoidBottomInset: true,
          body: GetBuilder<RegistrationController>(
            builder: (controller) {
              controller.residenceLoading
                  ? context.loaderOverlay.show()
                  : context.loaderOverlay.hide();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w),
                      height: (widget.isEdit!)
                          ? fixDpiScreenHeight() * 0.68
                          : fixDpiScreenHeight() * 0.8,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              Stack(
                                children: [
                                  AvatarWidget(
                                      radius: 36.w,
                                      // imageScale: 2.0,
                                      backgroundColor: Styles.avatarsBackground[
                                          controller.authService.getUserProfile!
                                              .avatarId!],
                                      imageAsset: AppImages.avatars[controller
                                          .authService
                                          .getUserProfile!
                                          .avatarId!],
                                      isSelected: true),
                                  widget.isEdit!
                                      ? Positioned(
                                          bottom: 0.0,
                                          right: 0.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.EDITSELECTAVATAR);
                                            },
                                            child: Image.asset(
                                              'assets/icons/edit-icon.png',
                                              width: 32.w,
                                              height: 32.w,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),

                              TitleText(
                                  title: widget.isEdit!
                                      ? AppStrings.editAccountInfos.tr
                                      : AppStrings.accountInfos.tr),
                              if (!widget.isEdit!)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.EditACCOUNT);
                                      },
                                      child: Image.asset(
                                        'assets/icons/edit-icon.png',
                                        width: 40.h,
                                        height: 40.h,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.CHANGEPASSWORD);
                                      },
                                      child: Image.asset(
                                        'assets/icons/reset-pass.png',
                                        width: 40.h,
                                        height: 40.h,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 24.h,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                fillColor: const Color(0xffF8F8F8),
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
                                fillColor: const Color(0xffF8F8F8),
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
                                validationFunc: (val) =>
                                    validateEgyptionPassport(
                                        _egPassportNumTxtController.text),
                                inputData: TextInputType.text,
                                enabled: widget.isEdit,
                                controller: _egPassportNumTxtController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                    return Stack(
                                      children: [
                                        CustomTextFormField(
                                          // controller:
                                          //     controller.residenceTxtController,
                                          validationFunc: (val) =>
                                              validateCountry(
                                                  residence.toString()),
                                          enabled: false,
                                        ),
                                        widget.isEdit!
                                            ? const Positioned(
                                                top: 14,
                                                left: 10,
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Styles.primaryColor,
                                                  size: 20,
                                                ))
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: SelectorButton(
                                              countries:
                                                  controller.countriesList,
                                              selectedCountry: residence,
                                              // country: controller.countriesList[0],
                                              selectorTextStyle: null,
                                              searchBoxDecoration: null,
                                              autoFocusSearchField: false,
                                              locale: null,
                                              onChanged: (val) {
                                                _residenceCountry.value =
                                                    controller
                                                        .countriesList[val!].id;
                                              },
                                              isEnabled: widget.isEdit!,
                                              isScrollControlled: true),
                                        ),
                                      ],
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
                                                        value: e.id,
                                                        child: Text(e.name),
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
                                            if (residenceTP == 1) {
                                              _residenceNumTxtController
                                                  .clear();
                                              _residenceAddressTxtController
                                                  .text = AuthService()
                                                      .getUserProfile
                                                      ?.residencyNo ??
                                                  "";
                                              _formKey.currentState!.validate();
                                            } else if (residenceTP == 2) {
                                              _forignPassportNumTxtController
                                                  .clear();
                                              _forignPassportNumTxtController
                                                  .text = AuthService()
                                                      .getUserProfile
                                                      ?.foreignPassportNo ??
                                                  "";

                                              _formKey.currentState!.validate();
                                            }
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                        if (residenceTP == 1)
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                        if (residenceTP == 2)
                                          TextFieldTitle(
                                              title: AppStrings
                                                  .forignPassportNum.tr,
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
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
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
                                  validationFunc: (val) => maxLenghtValidation(
                                      _residenceAddressTxtController.text, 200),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                    return Stack(
                                      children: [
                                        CustomTextFormField(
                                          // controller:
                                          //     controller.residenceTxtController,
                                          // validationFunc: (val) =>
                                          //     validateCountry(
                                          //         residence.toString()),
                                          enabled: false,
                                        ),
                                        widget.isEdit!
                                            ? const Positioned(
                                                top: 14,
                                                left: 10,
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Styles.primaryColor,
                                                  size: 20,
                                                ))
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: JobCategorySelectorButton(
                                              jobCategories:
                                                  controller.jobCategoryList,
                                              selectedCat: category,
                                              // country: controller.countriesList[0],
                                              selectorTextStyle: null,
                                              searchBoxDecoration: null,
                                              autoFocusSearchField: false,
                                              locale: null,
                                              onChanged: (val) {
                                                _jobCategory.value = controller
                                                    .jobCategoryList[val!].id;
                                              },
                                              isEnabled: widget.isEdit!,
                                              isScrollControlled: true),
                                        ),
                                      ],
                                    );
                                  }),

                              // ValueListenableBuilder<int?>(
                              //     valueListenable: _jobCategory,
                              //     builder: (_, category, __) {
                              //       return DropDownListSelector(
                              //         dropDownList: widget.isEdit!
                              //             ? controller.jobCategoryList
                              //                 .map((e) => DropdownMenuItem(
                              //                       value: e.id,
                              //                       child: Text(e.name),
                              //                     ))
                              //                 .toList()
                              //             : [],
                              //         value: category,
                              //         hint: !widget.isEdit!
                              //             ? controller.jobCategoryList
                              //                         .firstWhereOrNull(
                              //                             (element) =>
                              //                                 element.id ==
                              //                                 category) !=
                              //                     null
                              //                 ? controller.jobCategoryList
                              //                     .firstWhereOrNull((element) =>
                              //                         element.id == category)!
                              //                     .name
                              //                 : ""
                              //             : "",
                              //         blackHint: true,
                              //         hintFontSize: 14,
                              //         hintFontWeight: FontWeight.w400,
                              //         onChangeFunc: (val) {
                              //           _jobCategory.value = val;
                              //         },
                              //       );
                              //     }),
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validationFunc: (val) =>
                                    validateEgyptionPhoneNum(
                                        _egptionPhoneNumTxtController.text),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                validationFunc: (val) => maxLenghtValidation(
                                    _msgsAddressTxtController.text, 200),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              //------------------

                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (widget.isEdit!)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 11.h),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 0), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.isEdit!)
                              CustomButton(
                                text: AppStrings.save.tr,
                                type: widget.isEdit!
                                    ? ButtonType.primary
                                    : ButtonType.disabled,
                                width: 300.w,
                                height: 50,
                                onPressed: () async {
                                  if (widget.isEdit! &&
                                      _formKey.currentState!.validate()) {
                                    await controller.editAccount(
                                        UserProfileModel(
                                            name: _nameTxtController.text,
                                            jobCategoryID: _jobCategory.value,
                                            residencyCountryId:
                                                _residenceCountry.value,
                                            residencyTypeId:
                                                _residenceType.value,
                                            residencyNo:
                                                _residenceNumTxtController.text,
                                            foreignPassportNo:
                                                _forignPassportNumTxtController
                                                    .text,
                                            residencyAddress:
                                                _residenceAddressTxtController
                                                    .text,
                                            jobTitle:
                                                _jobTitleTxtController.text,
                                            egyptionMobile:
                                                _egptionPhoneNumTxtController
                                                    .text,
                                            foreignMobile:
                                                _forignPhoneNumTxtController
                                                    .text,
                                            messagingAddress:
                                                _msgsAddressTxtController.text,
                                            passportNo:
                                                _egPassportNumTxtController
                                                    .text));
                                  }
                                  controller.update();
                                },
                              ),
                            if (widget.isEdit!)
                              SizedBox(
                                height: 8.h,
                              ),
                            if (widget.isEdit!)
                              CustomButton(
                                text: AppStrings.cancel.tr,
                                type: ButtonType.secondary,
                                width: 300.w,
                                height: 50,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
