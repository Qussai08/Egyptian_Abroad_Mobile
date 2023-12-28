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
                            Row(
                              children: [
                                ProgressIndicatorWidget(
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
                                        color: Color(0xff3F3D56)))
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
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
                            TextFieldTitle(title: AppStrings.nationalID.tr),
                            CustomTextFormField(
                              controller: controller.nationalIDTxtController,
                              validationFunc: (val) => validateNationalID(
                                  controller.nationalIDTxtController.text),
                              inputData: TextInputType.number,
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
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  AppStrings.nameDisclamer.tr,
                                  // TODO : change it to custom
                                  style: TextStyle(
                                      fontFamily: 'baloo',
                                      fontSize: fixDpiFont(10),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff698097)),
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
                                                      .countriesList.isEmpty)
                                                  ? <DropdownMenuItem>[]
                                                  : controller.countriesList
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e.id,
                                                            child: Row(
                                                              children: [
                                                                Image.network(
                                                                  e.flag,
                                                                  width: 21,
                                                                  height: 15,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(e.country),
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
                            // SizedBox(
                            //   height: 40.h,
                            // ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'بالمتابعة انت موافق على مشاركة بيانات الدخول مع تطبيق سيارات المصريين بالخارج',
                              textAlign: TextAlign.center,
                              style: Styles.getRegularStyle(
                                  color: Styles.lightBlack,
                                  fontSize: fixDpiFont(13)),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
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
                                  Get.offAll(() => CompleteAccountView());
                                  // AppResponse res =
                                  //     await controller.verifyMailAndNID();

                                  // if (res.status && res.data['data'] == true) {
                                  //   // TODO : call cars api
                                  //   // AppResponse verRes = await controller
                                  //   //     .createVerificationCode();
                                  //   // Get.to(() => OtpView(
                                  //   //       resendOtpTime: verRes.data['data']
                                  //   //           ['data']['resendOtp'],
                                  //   //     ));
                                  // } else {
                                  //   Get.showSnackbar(
                                  //     buildCustomToast(
                                  //       Get.context!,
                                  //       toastMsg:
                                  //           "الرقم القومي أو البريد الإلكتروني مُسجل بالفعل.",
                                  //       toastTitle: AppStrings.sorry.tr,
                                  //       toastType: ToastType.error,
                                  //     ),
                                  //   );
                                  // }
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
                                    // TODO : use custom style
                                    style: TextStyle(
                                        color: Styles.primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontFamily: "baloo",
                                        fontSize: fixDpiFont(11),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('English Language support coming soon',
                                    style: TextStyle(
                                        color: Color(0xff667085),
                                        fontFamily: "baloo",
                                        fontSize: fixDpiFont(13),
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.language,
                                  color: Color(0xff667085),
                                  size: fixDpiWidth(16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
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
