import 'package:egyptians_abroad/app/core/constants/storage_constants.dart';
import 'package:egyptians_abroad/app/core/services/base_api.dart';
import 'package:egyptians_abroad/app/core/services/storage_service.dart';
import 'package:get/get.dart';

import '../../../core/constants/globals.dart';
import '../../../core/helper/localization_helper.dart';
import '../../../core/helper/notification_helper.dart';
import '../../../core/helper/security_helper.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/cars_base_api.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  var notificationHelper = NotificationHelper();

  @override
  void onInit() {
    super.onInit();
    BaseApi.initializeDio();
    CarsBaseApi.initializeDio();
    LocalizationHelper().changeLocale(
        Language.arabic); // TODO: Change this to the user's preferred language
    _startDelay();
  }

  _startDelay() {
    Future.delayed(const Duration(seconds: 1), _goNext);
  }

  _goNext() async {
    String? token = authService.accessToken;
    if (token?.isNotEmpty ?? false) {
      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic(Constants.fcmTopic);
      await 1.delay();

      final storageService = Get.find<StorageService>();
      var notificationId =
          storageService.getData(StorageConstants.kNotificationId);
      if (notificationId != null) {
        Get.offAllNamed(Routes.BOTTOMNAVIGATION,
            arguments: [int.parse(notificationId), 1]);
      } else {
        Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      }
    } else {
      await 1.delay();
      Get.offAllNamed(Routes.LOGIN);
    }
// Hashed Due to Testing purposes and should be enabled for Penetration Testing
    SecurityHelper.checkIsNotNormal();
  }
}
