import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';
import '../../../core/helper/notification_helper.dart';
import '../../../core/language/app_string.dart';
import '../../../core/services/app_response.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/repositories/user_repository.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find();
  var notificationHelper = NotificationHelper();

  RxBool loginIsDimmed = false.obs;
  RxBool isLoading = false.obs;

  Future<void> login(
      {required String email,
      required String pass,
      bool navigateToHome = true}) async {
    loginIsDimmed.value = true;
    isLoading.value = true;

    print(loginIsDimmed);

    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    print("login ${response.data}");
    if (response.status) {
      authService.setAccessToken(response.data['accessToken'] ?? '');
      authService.setRefreshToken(response.data['refreshToken'] ?? '');

      // await notificationHelper.registerFCMToken();
      // await notificationHelper.subscribeToTopic('broadcast');
      isLoading.value = false;
      if (navigateToHome) Get.offAllNamed(Routes.BOTTOMNAVIGATION);
    } else {
      print("resdd ${response.statusCode}");

      isLoading.value = false;
      loginIsDimmed.value = false;
      if (response.statusCode == 500) {
        Get.showSnackbar(
          buildCustomToast(
            Get.context!,
            toastMsg: 'حدث خطأ ما',
            toastTitle: AppStrings.sorry.tr,
            toastType: ToastType.error,
          ),
        );
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
}
