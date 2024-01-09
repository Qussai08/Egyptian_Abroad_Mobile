import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/otp/views/otp_view.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/complete_account_residence.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_appbar.dart';

class CarsFirstStepView extends StatefulWidget {
  const CarsFirstStepView({super.key});

  @override
  State<CarsFirstStepView> createState() => _CarsFirstStepViewState();
}

class _CarsFirstStepViewState extends State<CarsFirstStepView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  bool showCountryError = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: GetBuilder<RegistrationController>(
            builder: (registrationController) => registrationController
                    .countriesLoading
                ? SizedBox(
                    height: fixDpiScreenHeight(),
                    width: fixDpiScreenWidth(),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Styles.primaryColor,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        height: fixDpiScreenHeight() * 0.67,
                        child: SingleChildScrollView(
                          child: Form(
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
                                const TitleText(title: "إنشاء الملف التعريفي"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    const ProgressIndicatorWidget(
                                      step: '1',
                                      total: '4',
                                    ),
                                    SizedBox(width: 8.w),
                                    // todo: translate
                                    Text('البيانات الشخصية',
                                        style: TextStyle(
                                            fontFamily: 'baloo',
                                            fontSize: fixDpiFont(17),
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff3F3D56)))
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFieldTitle(title: AppStrings.email.tr),
                                CustomTextFormField(
                                  // TODO : check this senario
                                  enabled: false,
                                  controller: controller.emailTxtController,
                                  validationFunc: (val) => validateUserEmail(
                                      controller.emailTxtController.text),
                                  inputData: TextInputType.emailAddress,
                                  fillColor: const Color(0xffF8F8F8),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                TextFieldTitle(title: AppStrings.nationalID.tr),
                                CustomTextFormField(
                                  controller:
                                      controller.nationalIDTxtController,
                                  validationFunc: (val) => validateNationalID(
                                      controller.nationalIDTxtController.text),
                                  inputData: TextInputType.number,
                                  fillColor: controller.nationalIDTxtController
                                          .text.isNotEmpty
                                      ? const Color(0xffF8F8F8)
                                      : Colors.white,

                                  // TODO : check this senario
                                  enabled: controller
                                          .nationalIDTxtController.text.isEmpty
                                      ? true
                                      : false,
                                  maxLength: null,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                TextFieldTitle(title: AppStrings.name.tr),
                                CustomTextFormField(
                                  controller: controller.nameTxtController,
                                  validationFunc: (val) => validateName(
                                      controller.nameTxtController.text),
                                  inputData: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Styles.primaryColor,
                                      size: fixDpiWidth(16),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      AppStrings.nameDisclamer.tr,
                                      // TODO : change it to custom
                                      style: TextStyle(
                                          fontFamily: 'baloo',
                                          fontSize: fixDpiFont(10),
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff698097)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                TextFieldTitle(title: AppStrings.residence.tr),
                                GetBuilder<RegistrationController>(
                                  builder: (registrationController) =>
                                      ValueListenableBuilder<int?>(
                                          valueListenable:
                                              controller.residenceCountry,
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
                                                DropDownListSelector(
                                                  dropDownList: (controller
                                                          .countriesList
                                                          .isEmpty)
                                                      ? <DropdownMenuItem>[]
                                                      : controller.countriesList
                                                          .map((e) =>
                                                              DropdownMenuItem(
                                                                value: e.id,
                                                                child: Row(
                                                                  children: [
                                                                    Image
                                                                        .network(
                                                                      e.flag,
                                                                      width: 21,
                                                                      height:
                                                                          15,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(e
                                                                        .country),
                                                                  ],
                                                                ),
                                                              ))
                                                          .toList(),
                                                  borderColor: showCountryError ==
                                                              false &&
                                                          (registrationController
                                                                      .residenceCountry
                                                                      .value ==
                                                                  null ||
                                                              (registrationController
                                                                          .residenceCountry
                                                                          .value !=
                                                                      null &&
                                                                  validateCountry(registrationController
                                                                          .residenceCountry
                                                                          .value
                                                                          .toString()) ==
                                                                      null))
                                                      ? Styles.grey_200
                                                      : Colors.red,
                                                  value: residence,
                                                  hint: "",
                                                  onChangeFunc: (val) {
                                                    controller
                                                        .residenceTxtController
                                                        .text = val.toString();

                                                    controller.residenceCountry
                                                        .value = val;
                                                    // showCountryError = true;
                                                    // setState(() {});
                                                  },
                                                ),
                                              ],
                                            );
                                          }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    showCountryError = false;
                                  });
                                  // check if National exist in cars
                                  await controller.checkNIDInCars();
                                } else {
                                  if (validateCountry(registrationController
                                          .residenceCountry.value
                                          .toString()) !=
                                      null) {
                                    setState(() {
                                      showCountryError = true;
                                    });
                                  } else {
                                    setState(() {
                                      showCountryError = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            CustomButton(
                              text: AppStrings.cancel.tr,
                              type: ButtonType.secondary,
                              width: 358.w,
                              height: 50.h,
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
