import 'package:egyptians_abroad/app/modules/home/controllers/favorites_controller.dart';
import 'package:egyptians_abroad/app/modules/home/data/providers/favorites_list_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<FavoritesController>(FavoritesController());
    Get.put<HomeController>(
      HomeController(),
    );
  }
}
