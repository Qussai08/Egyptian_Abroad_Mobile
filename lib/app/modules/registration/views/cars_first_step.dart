import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/custom_widgets/selector_button.dart';

class CarsFirstStepView extends StatefulWidget {
  const CarsFirstStepView({super.key});

  @override
  State<CarsFirstStepView> createState() => _CarsFirstStepViewState();
}

class _CarsFirstStepViewState extends State<CarsFirstStepView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                : Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 18.h,
                        ),
                        Image.asset(
                          AppImages.user,
                          width: 56.w,
                          height: 56.w,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: const TitleText(
                                  title: "إنشاء الملف التعريفي")),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
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
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: TextFieldTitle(title: AppStrings.email.tr)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomTextFormField(
                            // TODO : check this senario
                            enabled: false,
                            controller: controller.emailTxtController,
                            validationFunc: (val) => validateUserEmail(
                                controller.emailTxtController.text),
                            inputData: TextInputType.emailAddress,
                            fillColor: const Color(0xffF8F8F8),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: TextFieldTitle(
                                title: AppStrings.nationalID.tr)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomTextFormField(
                            controller: controller.nationalIDTxtController,
                            validationFunc: (val) => validateNationalID(
                                controller.nationalIDTxtController.text,
                                carsRegister: true),
                            inputData: TextInputType.number,
                            fillColor: controller
                                    .nationalIDTxtController.text.isNotEmpty
                                ? const Color(0xffF8F8F8)
                                : Colors.white,

                            // TODO : check this senario
                            enabled:
                                controller.nationalIDTxtController.text.isEmpty
                                    ? true
                                    : false,
                            maxLength: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: TextFieldTitle(title: AppStrings.name.tr)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomTextFormField(
                            controller: controller.nameTxtController,
                            validationFunc: (val) => validateName(
                                controller.nameTxtController.text,
                                maxlength: 50),
                            inputData: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
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
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child:
                                TextFieldTitle(title: AppStrings.residence.tr)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GetBuilder<RegistrationController>(
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
                                            enabledBorderColor: controller
                                                            .showCountryError() ==
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
                                            validationFunc: (val) =>
                                                validateCountry(
                                                    residence.toString()),
                                            // enabled: false,
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
                                              // country: controller.countriesList[0],
                                              selectorTextStyle: null,
                                              searchBoxDecoration: null,
                                              autoFocusSearchField: false,
                                              locale: null,
                                              onChanged: (val) {
                                                controller.residenceCountry
                                                        .value =
                                                    controller
                                                        .countriesList[val!].id;
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
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 150.h,
                          // padding: EdgeInsets.symmetric(vertical: 15.h),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3D6C63FF),
                                blurRadius: 24,
                                offset: Offset(0, -12), // Shadow position
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                text: AppStrings.next.tr,
                                icon: Icons.arrow_forward,
                                type: ButtonType.primary,
                                width: 358.w,
                                height: 50.h,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // setState(() {
                                    //   showCountryError = false;
                                    // });
                                    controller.showCountryError = true.obs;

                                    // check if National exist in cars
                                    await controller.checkNIDInCars();
                                  } else {
                                    if (validateCountry(registrationController
                                            .residenceCountry.value
                                            .toString()) !=
                                        null) {
                                      controller.showCountryError = true.obs;
                                    } else {
                                      controller.showCountryError = false.obs;
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
                                  registrationController.passwordTxtController
                                      .clear();
                                  registrationController.emailTxtController
                                      .clear();
                                  registrationController.nationalIDTxtController
                                      .clear();
                                  registrationController.nameTxtController
                                      .clear();
                                  registrationController
                                      .residenceCountry.value = null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
