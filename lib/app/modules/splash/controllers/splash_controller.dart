
import 'package:egyptians_abroad/app/core/services/base_api.dart';
import 'package:get/get.dart';

import '../../../core/helper/localization_helper.dart';
import '../../../core/helper/notification_helper.dart';
import '../../../core/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  var notificationHelper = NotificationHelper();

  @override
  void onInit() {
    super.onInit();
    BaseApi.initializeDio();
    LocalizationHelper().changeLocale(
        Language.arabic); // TODO: Change this to the user's preferred language
    _startDelay();
  }

  _startDelay() {
    Future.delayed(const Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    // print("authService.isAuth ${await authService.isAuth}");
    // var token = await SecureStorageHelper.localRead('token');
    String? token = authService.accessToken;

    if (token?.isNotEmpty ?? false) {
      // token = json.decode(token);
      // AppHelper.setToken(token);
      // authService.setAccessToken(token!);
      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic('broadcast');
      await 2.delay();
      Get.offAllNamed(Routes.BOTTOMNAVIGATION);
    } else {
      await 2.delay();
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
