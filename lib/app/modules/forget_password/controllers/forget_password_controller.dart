import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/modules/forget_password/views/forget_pass_otp.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../core/helper/error_helper.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailTxtController = TextEditingController();
  final OtpFieldController otpTxtController = OtpFieldController();
  String otp = '';
  final TextEditingController newPasswordTxtController =
      TextEditingController();
  final TextEditingController confirmNewPassTxtController =
      TextEditingController();

  // RxString errorMessage = ''.obs;
  // RxBool showValidation = false.obs;

  Future<void> verifyMail() async {
    AppResponse response = await UserRepository().checkEmailAndNIIfExist(
        queryParameters: {
          "email": emailTxtController.text,
          "NID": "00000000000000"
        });

    if (!response.data['data']) {
      AppResponse verRes = await createVerificationCode();
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: AppStrings.otpSentSuccessfully.tr,
          toastTitle: AppStrings.confirm.tr,
          toastType: ToastType.success,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (verRes.status) {
          otp = '';
          Get.to(() => ForgetPassOtpView(
                resendOtpTime: verRes.data['data']['data']['resendOtp'],
              ));
        }
      });
    } else {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: "البريد الإلكتروني غير مُسجل",
          toastTitle: AppStrings.sorry.tr,
          toastType: ToastType.error,
        ),
      );
    }
  }

  Future<AppResponse> verifyCode(otp) async {
    AppResponse response = await UserRepository()
        .verifiyOtp({"email": emailTxtController.text, "code": otp});
    return response;
  }

  Future<AppResponse> createVerificationCode() async {
    AppResponse response = await UserRepository().createOtp(queryParameters: {
      "email": emailTxtController.text,
      "verificationType": 2
    });
    if (response.status) {
    }
    return response;
  }

  Future<void> forgetPass() async {
    Map<String, dynamic> reqBody = {
      "newPassword": newPasswordTxtController.text,
      "confirmNewPassword": confirmNewPassTxtController.text,
      "email": emailTxtController.text,
      "code": otp
    };
    try {
      AppResponse response = await UserRepository().forgetPasswordReq(reqBody);
      if (response.status) {
        Get.showSnackbar(
          buildCustomToast(
            Get.context!,
            toastMsg: "تم تعديل كلمة المرور بنجاح",
            toastTitle: AppStrings.confirm.tr,
            toastType: ToastType.success,
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Get.back(closeOverlays: true);

          Get.toNamed(Routes.LOGIN);
          emailTxtController.clear();
          newPasswordTxtController.clear();
          confirmNewPassTxtController.clear();
        });
      }
    } catch (e) {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: ErrorHelper.getErrorMessage('genrealError'),
          toastTitle: 'عفواً',
          toastType: ToastType.error,
        ),
      );
    }
  }
}
