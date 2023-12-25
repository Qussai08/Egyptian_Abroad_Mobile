import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  changeView(String route) {
    Get.toNamed(route);
  }

  Future<void> onLogout() async {
    await AuthService().logout();
  }
}
