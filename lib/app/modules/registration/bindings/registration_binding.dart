import 'package:egyptians_abroad/app/modules/home/data/providers/favorites_list_provider.dart';
import 'package:get/get.dart';

import '../../home_showcase/data/providers/favorites_list_provider.dart';
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
    Get.lazyPut<FavoritesListProvider>(
      () => FavoritesListProvider(),
    );
  }
}
