import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';
import '../../../core/helper/notification_helper.dart';
import '../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find();
  var notificationHelper = NotificationHelper();

  Future<void> login({required String email, required String pass}) async {
    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    if (response.status) {
      authService.setAccessToken(response.data['accessToken'] ?? '');
      authService.setRefreshToken(response.data['refreshToken'] ?? '');
      String? userID = authService.userID ?? '';

      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic('broadcast');

      Get.offAllNamed(Routes.BOTTOMNAVIGATION);
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
