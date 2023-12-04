import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login({required String email, required String pass}) async {
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    if (response.status) {
      Get.offAllNamed(Routes.BOTTOMNAVIGATION);
    } else {
      Get.showSnackbar(
        GetSnackBar(
          titleText: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
                size: fixDpiHeight(24),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                AppStrings.sorry.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fixDpiFont(18),
                    fontWeight: FontWeight.w700,
                    fontFamily: "baloo"),
              ),
            ],
          ),
          messageText: Text(
            AppStrings.invalidMailOrPass.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: fixDpiFont(14),
                fontWeight: FontWeight.w400,
                fontFamily: "baloo"),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          borderRadius: 16,
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.only(top: 12),
          snackStyle: SnackStyle.GROUNDED,
        ),
      );
    }
  }
}
