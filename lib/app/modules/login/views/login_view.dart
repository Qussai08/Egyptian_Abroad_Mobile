import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/login/views/widgets/footer.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_images.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with ValidationMixin {
  final TextEditingController _emailTxtController = TextEditingController();
  final TextEditingController _passwordTxtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.only(top: 48.h, right: 16.w, left: 16.w),
            height: fixDpiScreenHeight(),
            width: fixDpiScreenWidth(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // change language widget
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     ChangeLangButtonWidget(),
                  //   ],
                  // ),

                  // End

                  Image.asset(
                    AppImages.travel,
                    width: 56.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TitleText(title: AppStrings.logIn.tr),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextFieldTitle(title: AppStrings.email.tr),
                  CustomTextFormField(
                    hintTxt: 'Username@example.info',
                    controller: _emailTxtController,
                    validationFunc: (val) =>
                        validateUserEmail(_emailTxtController.text),
                    inputData: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextFieldTitle(title: AppStrings.password.tr),
                  CustomTextFormField(
                    hintTxt: '**************',
                    controller: _passwordTxtController,
                    validationFunc: (val) =>
                        validatePassword(_passwordTxtController.text),
                    inputData: TextInputType.text,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.FORGETPASSWORD);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            AppStrings.forgetPassword.tr,
                            style: Styles.getRegularStyle(
                                    color: Styles.primaryColor,
                                    fontSize: fixDpiFont(11))
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Styles.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: AppStrings.logIn.tr,
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 358.w,
                    height: 50.h,
                    fontSize: fixDpiFont(16),
                    iconSize: fixDpiFont(16),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await controller.login(
                          email: _emailTxtController.text,
                          pass: _passwordTxtController.text,
                          navigateToHome: true);
                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    width: 358.w,
                    height: 50.h,
                    fontSize: fixDpiFont(16),
                    type: ButtonType.ghost,
                    iconIsAsset: true,
                    assetString: AppImages.carsIcon,
                    changeIconPosition: true,
                    text: AppStrings.registerWithCarsAccount.tr,
                    textColor: Styles.black3,
                  ),

                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.donotHaveAccount.tr,
                        style: Styles.getRegularStyle(
                            color: Styles.lightBlack, fontSize: fixDpiFont(11)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.REGISTRATION,
                          );
                        },
                        child: Text(
                          AppStrings.register.tr,

                          // New style
                          style: Styles.getRegularStyle(
                                  color: Styles.primaryColor,
                                  fontSize: fixDpiFont(11))
                              .copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Styles.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 51.h),
                  const FooterWidget(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
