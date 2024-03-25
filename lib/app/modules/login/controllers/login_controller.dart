import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:get/get.dart';

import '../../../core/constants/globals.dart';
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

  onInit() {
    super.onInit();
    Get.lazyPut(() => RegistrationController());
  }

  RxBool loginIsDimmed = false.obs;
  RxBool isLoading = false.obs;

  onRegister() {
    RegistrationController registrationController;
    if (Get.isRegistered<RegistrationController>()) {
      registrationController = Get.find<RegistrationController>();
    } else {
      registrationController = Get.put(RegistrationController());
    }
    registrationController.setRegisterWithCars(false);
    registrationController.getCountriesList();

    Get.toNamed(Routes.REGISTRATION);
  }

  Future<void> login(
      {required String email,
      required String pass,
      bool navigateToHome = true}) async {
    loginIsDimmed.value = true;
    isLoading.value = true;


    AppResponse response =
        await UserRepository().loginReq({"email": email, "password": pass});
    if (response.status) {
      authService.setAccessToken(response.data['accessToken'] ?? '');
      authService.setRefreshToken(response.data['refreshToken'] ?? '');

      await notificationHelper.registerFCMToken();
      await notificationHelper.subscribeToTopic(Constants.fcmTopic);
      isLoading.value = false;
      if (navigateToHome) Get.offAllNamed(Routes.BOTTOMNAVIGATION);
    } else {

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
