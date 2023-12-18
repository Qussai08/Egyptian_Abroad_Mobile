import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';
import '../controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
