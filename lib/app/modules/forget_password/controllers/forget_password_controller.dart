import 'package:egyptians_abroad/app/core/custom_widgets/custom_dialog.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
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

  Future<void> verifyMail() async {
    AppResponse response = await UserRepository().checkEmailAndNIIfExist(
        queryParameters: {
          "email": emailTxtController.text,
          "NID": "00000000000000"
        });
    if (!response.data['data']) {
      await createVerificationCode();
      Get.toNamed(Routes.FORGETPASSOTP);
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

  Future<void> createVerificationCode() async {
    AppResponse response = await UserRepository().createOtp(queryParameters: {
      "email": emailTxtController.text,
      "verificationType": 2
    });
    if (response.status) {
      print("createVerificationCode : ${response.status}");
    }
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
