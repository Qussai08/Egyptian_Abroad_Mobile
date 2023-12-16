import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';
import '../../../core/helper/notification_helper.dart';
import '../../../core/helper/secure_storage_helper.dart';
import '../../../core/language/app_string.dart';
import '../../../core/services/app_response.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/repositories/user_repository.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find();
  var notificationHelper = NotificationHelper();

  Future<void> login(
      {required String email,
      required String pass,
      bool navigateToHome = true}) async {
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    print("login res ${response.data}");
    if (response.status) {
      authService.setAccessToken(response.data['accessToken'] ?? '');
      authService.setRefreshToken(response.data['refreshToken'] ?? '');
      // String? userID = authService.userID ?? '';

      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic('broadcast');

      // Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      if (navigateToHome) Get.offAllNamed(Routes.BOTTOMNAVIGATION);
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
