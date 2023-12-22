import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, this.resendOtpTime});
  final int? resendOtpTime;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _otpHasError = ValueNotifier(false);
  String? errormsg;

  intl.NumberFormat formatter = intl.NumberFormat("00");

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    int endTime = DateTime.now().millisecondsSinceEpoch +
        1000 * (widget.resendOtpTime ?? 2) * 60;

    return NetworkIndicator(
      child: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
            body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 30.h, right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.fingerPrint,
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
                      titleTextStyle:
                          Styles.getRegularStyle(color: Styles.lightBlack),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.w),
                      child: ValueListenableBuilder<bool>(
                          valueListenable: _otpHasError,
                          builder: (_, hasError, __) {
                            return Column(
                              children: [
                                Directionality(
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
                                    textFieldAlignment:
                                        MainAxisAlignment.spaceAround,
                                    fieldStyle: FieldStyle.box,
                                    controller: controller.otpTxtController,
                                    hasError: hasError,
                                    contentPadding:
                                        const EdgeInsets.only(left: 5),
                                    onChanged: (pin) {
                                      controller.otp = pin;
                                    },
                                    onCompleted: (pin) async {
                                      _otpHasError.value =
                                          validateOtpCode(pin) != null
                                              ? true
                                              : false;

                                      AppResponse res =
                                          await controller.verifyCode(pin);
                                      print("res verifyCode ${res.data}");
                                      if (res.status &&
                                          res.data['data'] == true) {
                                        controller.otp = pin;
                                        Get.toNamed(Routes.SETPASSWORD);
                                      } else {
                                        _otpHasError.value = true;
                                      }
                                    },
                                  ),
                                ),
                                if (hasError &&
                                    validateOtpCode(controller.otp) !=
                                        AppStrings.otpEmptyValidation.tr)
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (validateOtpCode(controller.otp) !=
                                            AppStrings.otpEmptyValidation.tr)
                                          Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: fixDpiHeight(24),
                                          ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          validateOtpCode(controller.otp) ==
                                                  AppStrings
                                                      .otpEmptyValidation.tr
                                              ? ""
                                              : AppStrings.sorry.tr,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: fixDpiFont(18),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "baloo"),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (hasError)
                                  Text(
                                    validateOtpCode(controller.otp) ==
                                            AppStrings.otpEmptyValidation.tr
                                        ? ""
                                        : "كود التحقق غير صحيح",
                                    textAlign: TextAlign.center,
                                    style: Styles.getRegularStyle(
                                        color: Styles.red),
                                  ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (context, time) {
                        return Column(
                          children: [
                            time == null
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 110.w),
                                    child: CustomButton(
                                        text: AppStrings.resendCode.tr,
                                        type: ButtonType.secondary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        height: 40,
                                        onPressed: () async {
                                          await controller
                                              .createVerificationCode();
                                          endTime = DateTime.now()
                                                  .millisecondsSinceEpoch +
                                              1000 * 600;
                                          _otpHasError.value = false;
                                          controller.otpTxtController.clear();
                                          setState(() {});
                                        }),
                                  )
                                : Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Styles.secondaryButtonColor,
                                    ),
                                    child: Text(
                                      " إعادة إرسال خلال "
                                      '${formatter.format(time.min ?? 00)}:${formatter.format(time.sec ?? 00)}',
                                      style: TextStyle(
                                          fontFamily: 'baloo',
                                          fontWeight: FontWeight.w400,
                                          fontSize: fixDpiFont(12)),
                                    ),
                                  ),
                            SizedBox(
                              height: 50.h,
                            ),
                            CustomButton(
                              text: AppStrings.confirm.tr,
                              icon: Icons.arrow_forward,
                              type: ButtonType.primary,
                              width: 300.w,
                              height: 50,
                              onPressed: () async {
                                if (time == null) {
                                  _otpHasError.value = true;
                                } else {
                                  _otpHasError.value =
                                      validateOtpCode(controller.otp) != null
                                          ? true
                                          : false;
                                }

                                if (_otpHasError.value == false) {
                                  errormsg = validateOtpCode(controller.otp);
                                  if (errormsg ==
                                      AppStrings.otpEmptyValidation.tr) {
                                    setState(() {});
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
