import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/secure_storage_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';

class LoginController extends GetxController {
  Future<void> login(
      {required String email,
      required String pass,
      bool navigateToHome = true}) async {
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    print("login res ${response.data}");
    if (response.status) {
      if (navigateToHome) Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      AppHelper.setToken(response.data['accessToken']);
      SecureStorageHelper.localWrite(
          'user', {"email": email, "password": pass});
    } else {
      // Get.offAllNamed(Routes.BOTTOMNAVIGATION);

      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: AppStrings.invalidMailOrPass.tr,
          toastTitle: AppStrings.sorry.tr,
          toastType: ToastType.error,
        ),
      );
    }
  }
}
