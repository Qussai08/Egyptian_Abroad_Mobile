import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';

class LoginController extends GetxController {
  Future<void> login({required String email, required String pass}) async {
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    if (response.status) {
      Get.offAllNamed(Routes.BOTTOMNAVIGATION);
    } else {
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
