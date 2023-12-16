import 'package:egyptians_abroad/app/modules/edit_account/controller/edit_account_controller.dart';
import 'package:get/get.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EditAccountController>(
      EditAccountController(),
    );
  }
}
