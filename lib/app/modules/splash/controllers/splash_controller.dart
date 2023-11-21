import 'package:get/get.dart';

import '../../../core/helper/localization_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  // final AppPreferences _appPref = Get.find<AppPreferences>();

  @override
  void onInit() {
    super.onInit();
    LocalizationHelper().changeLocale(
        Language.arabic); // TODO: Change this to the user's preferred language
    _startDelay();
  }

  _startDelay() {
    Future.delayed(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    Get.offAllNamed(Routes.LOGIN); // For now ;)
    // if (await _appPref.isUserLogged()) {
    //   Get.offAllNamed(Routes.Home);
    // } else {
    //   Get.offAllNamed(Routes.LOGIN);
    // }
  }
}
