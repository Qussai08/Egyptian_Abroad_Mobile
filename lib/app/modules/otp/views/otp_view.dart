import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';


class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  // final OtpFieldController _otpTxtController = OtpFieldController();
  final ValueNotifier<bool> _otpHasError = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
          body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Fingerprint2.png',
                    width: 333.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TitleText(
                    title: AppStrings.otpTitle.tr,
                    fontSize: 22,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TitleText(
                    title: AppStrings.otpDiscription.tr,
                    titleTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Styles.lightBlack,
                        fontFamily: 'baloo'),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.w),
                    child: ValueListenableBuilder<bool>(
                        valueListenable: _otpHasError,
                        builder: (_, hasError, __) {
                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: OTPTextField(
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              outlineBorderRadius: 24,
                              otpFieldStyle: OtpFieldStyle(
                                focusBorderColor: Styles.primaryColor,
                              ),
                              fieldWidth: 50,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              keyboardType: TextInputType.number,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              // controller: _otpTxtController,
                              hasError: hasError,
                              onChanged: (pin) {},
                              onCompleted: (pin) async {
                                _otpHasError.value =
                                    validateOtpCode(pin) != null ? true : false;
                                print(validateOtpCode(pin));

                                if (!hasError) {
                                  Get.toNamed(
                                    Routes.SETPASSWORD,
                                  );
                                }
                              },
                            ),
                          );
                        }),
                  ),

                  ///

                  // TODO : add resend in widget
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
