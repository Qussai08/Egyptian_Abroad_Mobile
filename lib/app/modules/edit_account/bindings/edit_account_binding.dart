import 'package:egyptians_abroad/app/modules/edit_account/controller/edit_account_controller.dart';
import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';
import '../../registration/controllers/registration_controller.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
    );
    Get.put<RegistrationController>(
      RegistrationController(),
    );
    Get.put<EditAccountController>(
      EditAccountController(),
    );
  }
}
