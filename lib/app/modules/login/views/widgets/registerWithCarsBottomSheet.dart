import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/custom_widgets/textfield_title.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/helper/validators.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/app_images.dart';
import '../../../../core/theme/styles.dart';
import '../../../registration/controllers/registration_controller.dart';

class RegisterWithCarsBottomSheet extends StatefulWidget {
  const RegisterWithCarsBottomSheet({super.key});

  @override
  State<RegisterWithCarsBottomSheet> createState() =>
      _RegisterWithCarsBottomSheetState();
}

class _RegisterWithCarsBottomSheetState
    extends State<RegisterWithCarsBottomSheet> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  bool intialRun = true;
  bool formValid = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    RegistrationController registrationController;
    if (Get.isRegistered<RegistrationController>()) {
      registrationController = Get.find();
    } else {
      registrationController = Get.put(RegistrationController());
    }

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        height: intialRun || formValid ? 430.h : 510.h,
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),

            decoration: const BoxDecoration(
                color: Color(0xffE7F2F4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            // height: 100.h,
            child: Row(children: [
              Container(
                width: fixDpiFont(24),
              ),
              Spacer(),
              Container(
                width: 190.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.carsIcon,
                      height: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "التسجيل باستخدام تطبيق سيارات المصريين بالخارج",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Styles.getRegularStyle(
                          color: Color(0xff201D61), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                  registrationController.passwordTxtController.clear();
                  registrationController.emailTxtController.clear();
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Icon(
                    Icons.close,
                    size: fixDpiFont(24),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFieldTitle(title: AppStrings.email.tr),
                    CustomTextFormField(
                      hintTxt: 'Username@example.info',
                      controller: registrationController.emailTxtController,
                      validationFunc: (val) => validateUserEmail(
                          registrationController.emailTxtController.text),
                      inputData: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldTitle(title: AppStrings.password.tr),
                    CustomTextFormField(
                      hintTxt: '**************',
                      controller: registrationController.passwordTxtController,
                      validationFunc: (val) => validatePassword(
                          registrationController.passwordTxtController.text),
                      inputData: TextInputType.text,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'سيتم مشاركه بيانات الدخول و الرقم القومي لتطبيق سيارات المصريين بالخارج مع تطبيق المصريين بالخارج',
                      textAlign: TextAlign.center,
                      style: Styles.getRegularStyle(
                          color: Styles.lightBlack, fontSize: fixDpiFont(13)),
                    ),
                    // Spacer(),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                      type: ButtonType.primary,
                      text: 'موافق',
                      onPressed: () async {
                        formValid = _formKey.currentState!.validate();
                        if (!formValid) {
                          if (intialRun) {
                            intialRun = false;
                          }
                          setState(() {});
                          return;
                        }
                        await registrationController.verifyCarsMail();
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
