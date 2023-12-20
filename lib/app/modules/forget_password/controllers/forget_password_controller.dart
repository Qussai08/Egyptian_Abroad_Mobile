import 'package:egyptians_abroad/app/core/custom_widgets/custom_dialog.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/modules/forget_password/views/forget_pass_otp.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailTxtController = TextEditingController();
  final OtpFieldController otpTxtController = OtpFieldController();
  String otp = '';
  final TextEditingController newPasswordTxtController =
      TextEditingController();
  final TextEditingController confirmNewPassTxtController =
      TextEditingController();
  String otp = '';
  RxString errorMessage = ''.obs;
  RxBool showValidation = false.obs;

  Future<void> verifyMail() async {
    AppResponse response = await UserRepository().checkEmailAndNIIfExist(
        queryParameters: {
          "email": emailTxtController.text,
          "NID": "00000000000000"
        });
    print("response.data ${response.data}");

    if (!response.data['data']) {
      AppResponse verRes = await createVerificationCode();
      print("verRes ${verRes.data}");
      // Get.toNamed(Routes.FORGETPASSOTP);
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: AppStrings.otpSentSuccessfully.tr,
          toastTitle: AppStrings.confirm.tr,
          toastType: ToastType.success,
        ),
      );
      if (verRes.status) {
        Get.to(() => ForgetPassOtpView(
              resendOtpTime: verRes.data['data']['data']['resendOtp'],
            ));
      }
    } else {
      buildCustomDialog(
          // TODO : translate
          dialogMsg: "البريد الإلكتروني غير مُسجل",
          dialogType: DialogType.error);
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
      print("createVerificationCode : ${response.status}");
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

    AppResponse response = await UserRepository().forgetPasswordReq(reqBody);
    if (response.status) {
      buildCustomDialog(
          // TODO : translate
          dialogMsg: "تم تعديل كلمة المرور بنجاح",
          dialogType: DialogType.success);
      Future.delayed(const Duration(seconds: 1), () async {
        Get.back(closeOverlays: true);

        Get.toNamed(Routes.LOGIN);
        emailTxtController.clear();
        newPasswordTxtController.clear();
        confirmNewPassTxtController.clear();
      });
    }
  }
}
