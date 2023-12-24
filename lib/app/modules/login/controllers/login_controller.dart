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

  Future<void> login(
      {required String email,
      required String pass,
      bool navigateToHome = true}) async {
    loginIsDimmed.value = true;
    print(loginIsDimmed);
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    if (response.status) {
      authService.setAccessToken(response.data['accessToken'] ?? '');
      authService.setRefreshToken(response.data['refreshToken'] ?? '');
      // String? userID = authService.userID ?? '';
      // AppHelper.setToken(response.data['accessToken']);

      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic('broadcast');

      if (navigateToHome) Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      // SecureStorageHelper.localWrite('token', response.data['accessToken']);
    } else {
      loginIsDimmed.value = false;
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
