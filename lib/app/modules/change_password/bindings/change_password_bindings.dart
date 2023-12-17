import 'package:egyptians_abroad/app/modules/change_password/controllers/change_password_controller.dart';
import 'package:get/get.dart';
import '../data/providers/change_password_provider.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangePasswordProvider>(ChangePasswordProvider());

    Get.put<ChangePasswordController>(
      ChangePasswordController(),
    );
  }
}
