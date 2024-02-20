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
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/complete_account_work.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'select_avatar.dart';

class CompleteAccountView extends StatefulWidget {
  const CompleteAccountView({super.key, this.carRegister = false});
  final bool carRegister;
  @override
  State<CompleteAccountView> createState() => _CompleteAccountViewState();
}

class _CompleteAccountViewState extends State<CompleteAccountView>
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('carRegister ${widget.carRegister}');
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: widget.carRegister ? const CustomAppBar() : null,
          body: GetBuilder<RegistrationController>(
            builder: (registrationController) {
              registrationController.residenceLoading
                  ? context.loaderOverlay.show()
                  : context.loaderOverlay.hide();
              return Container(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 18.h),
                child: ListView(
                  children: [
                    SizedBox(height: !widget.carRegister ? 40.h : 0.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          Image.asset(
                            AppImages.user,
                            width: 56.w,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TitleText(title: AppStrings.completeAccountTitle.tr),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              !widget.carRegister
                                  ? const ProgressIndicatorWidget(step: '1')
                                  : const ProgressIndicatorWidget(
                                      step: '2',
                                      total: '4',
                                    ),
                              SizedBox(width: 8.w),
                              // todo: translate
                              Text('بيانات الإقامة',
                                  style: TextStyle(
                                      fontFamily: 'baloo',
                                      fontSize: fixDpiFont(17),
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff3F3D56)))
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFieldTitle(
                              title: AppStrings.egPassportNum.tr,
                              hasSubTitle: false),
                          CustomTextFormField(
                            controller: registrationController
                                .egPassportNumTxtController,
                            validationFunc: (val) => validateEgyptionPassport(
                                registrationController
                                    .egPassportNumTxtController.text),
                            inputData: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextFieldTitle(
                              title: AppStrings.residenceType.tr,
                              hasSubTitle: false),
                          ValueListenableBuilder<int?>(
                              valueListenable:
                                  registrationController.residenceType,
                              builder: (_, residenceTP, __) {
                                return Column(
                                  children: [
                                    DropDownListSelector(
                                      dropDownList: registrationController
                                          .residenceTypeList
                                          .map((e) => DropdownMenuItem(
                                                value: e.id,
                                                child: Text(e.name),
                                              ))
                                          .toList(),
                                      value: residenceTP,
                                      hint: "",
                                      onChangeFunc: (val) {
                                        registrationController
                                            .residenceType.value = val;
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    if (residenceTP == 1)
                                      TextFieldTitle(
                                          title: AppStrings.residenceNumber.tr,
                                          hasSubTitle: false),
                                    if (residenceTP == 1)
                                      CustomTextFormField(
                                        controller: registrationController
                                            .residenceNumTxtController,
                                        inputData: TextInputType.text,
                                        validationFunc: (val) =>
                                            maxLenghtValidation(
                                                registrationController
                                                    .residenceNumTxtController
                                                    .text,
                                                20),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                                        controller: registrationController
                                            .forignPassportNumTxtController,
                                        inputData: TextInputType.text,
                                        validationFunc: (val) =>
                                            maxLenghtValidation(
                                                registrationController
                                                    .residenceNumTxtController
                                                    .text,
                                                20),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                            controller: registrationController
                                .residenceAddressTxtController,
                            inputData: TextInputType.text,
                            validationFunc: (val) => maxLenghtValidation(
                                registrationController
                                    .residenceNumTxtController.text,
                                200),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          // SizedBox(height: 186.h),
                        ],
                      ),
                    ),
                    Container(
                      height: 186.h,
                      width: fixDpiScreenWidth(),
                      // width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
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
                          CustomButton(
                            text: AppStrings.next.tr,
                            icon: Icons.arrow_forward,
                            type: ButtonType.primary,
                            width: 358.w,
                            height: 50.h,
                            onPressed: () {
                              // registrationController.loadResidenceData();
                              if (_formKey.currentState!.validate()) {
                                if (widget.carRegister) {
                                  Get.to(() => const CompleteAccountWorkView(
                                        carRegister: true,
                                      ));
                                } else {
                                  Get.toNamed(Routes.COMPLETEACCOUNTWORK);
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomButton(
                            text: AppStrings.skip.tr,
                            type: ButtonType.secondary,
                            width: 358.w,
                            height: 50.h,
                            onPressed: () {
                              if (widget.carRegister) {
                                Get.to(() => const RegistrationSelectAvatarView(
                                      carRegister: true,
                                    ));
                              } else {
                                Get.toNamed(Routes.REGITSRATIONSELECTAVATAR);
                              }
                            },
                          ),
                        ],
                      ),
                    )
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
