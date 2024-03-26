import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/selector_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/helper/localization_helper.dart';
import '../../../routes/app_pages.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  // bool showCountryError = false;
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
                            TextFieldTitle(title: AppStrings.name.tr),
                            CustomTextFormField(
                              controller: controller.nameTxtController,
                              validationFunc: (val) => validateName(
                                  controller.nameTxtController.text),
                              inputData: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                            TextFieldTitle(title: AppStrings.nationalID.tr),
                            CustomTextFormField(
                              controller: controller.nationalIDTxtController,
                              validationFunc: (val) => validateNationalID(
                                  controller.nationalIDTxtController.text),
                              inputData: TextInputType.number,
                              maxLength: null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(title: AppStrings.email.tr),
                            CustomTextFormField(
                              controller: controller.emailTxtController,
                              validationFunc: (val) => validateUserEmail(
                                  controller.emailTxtController.text),
                              inputData: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                              controller: registrationController
                                                  .residenceTxtController,
                                              textStyle: const TextStyle(
                                                  color: Colors.white),
                                              validationFunc: (val) =>
                                                  validateCountry(
                                                      registrationController
                                                          .residenceTxtController
                                                          .text),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                            ),
                                            const Positioned(
                                                top: 14,
                                                left: 10,
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Styles.primaryColor,
                                                  size: 20,
                                                )),
                                            SelectorButton(
                                                countries:
                                                    controller.countriesList,
                                                selectedCountry: residence,
                                                selectorTextStyle: null,
                                                searchBoxDecoration: null,
                                                autoFocusSearchField: false,
                                                locale: null,
                                                onChanged: (val) {
                                                  controller.residenceCountry
                                                          .value =
                                                      controller
                                                          .countriesList[val!]
                                                          .id;

                                                  registrationController
                                                          .residenceTxtController
                                                          .text =
                                                      controller
                                                          .countriesList[val!]
                                                          .id
                                                          .toString();

                                                  if (residence != null) {
                                                    _formKey.currentState!
                                                        .validate();
                                                  }
                                                },
                                                isEnabled: true,
                                                isScrollControlled: true),
                                          ],
                                        );
                                      }),
                            ),
                            SizedBox(
                              height: 19.h,
                            ),
                            Text(
                              'بالمتابعة انت موافق على مشاركة بيانات الدخول مع تطبيق سيارات المصرين بالخارج',
                              textDirection: LocalizationHelper.isArabic()
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.getRegularStyle(
                                  color: Styles.lightBlack,
                                  fontSize: fixDpiFont(13)),
                            ),
                            SizedBox(
                              height: 19.h,
                            ),
                            CustomButton(
                              text: AppStrings.next.tr,
                              icon: Icons.arrow_forward,
                              iconSize: 14.w,
                              type: ButtonType.primary,
                              width: 358.w,
                              height: 50.h,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.checkNIDAndEmailInCars();
                                  //  verfiy on cars first then on egy abroad
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
                                    Get.offAllNamed(Routes.LOGIN);
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
