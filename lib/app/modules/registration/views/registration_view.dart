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
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>
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
                                                          .length ==
                                                      0)
                                                  ? <DropdownMenuItem>[]
                                                  : controller.countriesList
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            child:
                                                                Text(e.country),
                                                            value: e.id,
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
                                                  ? Color.fromARGB(
                                                      255, 237, 239, 240)
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
                                  setState(() {
                                    showCountryError = false;
                                  });
                                  AppResponse res =
                                      await controller.verifyMailAndNID();
                                  if (res.status && res.data['data'] == true) {
                                    await controller.createVerificationCode();
                                    Get.toNamed(
                                      Routes.OTP,
                                    );
                                  } else {
                                    Get.showSnackbar(
                                      buildCustomToast(
                                        Get.context!,
                                        toastMsg:
                                            "الرقم القومي أو البريد الإلكتروني مُسجل بالفعل.",
                                        toastTitle: AppStrings.sorry.tr,
                                        toastType: ToastType.error,
                                      ),
                                    );
                                  }
                                } else {
                                  print(
                                      " ddd  ${validateCountry(registrationController.residenceCountry.value.toString())}");

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
      ),
    );
  }
}
