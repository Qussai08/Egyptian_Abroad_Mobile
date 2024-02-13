import 'package:get/get.dart';

import '../controllers/home_showcase_controller.dart';

class HomeShowcaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeShowcaseController>(
      HomeShowcaseController(),
    );
  }
}
