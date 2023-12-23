import 'package:egyptians_abroad/app/modules/bottom_navigation.dart/controllers/bottom_navigation_controller.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:egyptians_abroad/app/modules/start_service/controllers/start_service_controller.dart';
import 'package:get/get.dart';

import '../../home_showcase/controllers/home_showcase_controller.dart';
import '../../home_showcase/data/providers/favorites_list_provider.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../notifications/data/providers/notifications_provider.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Favorites
    Get.put<FavoritesListProvider>(FavoritesListProvider());
    Get.put<StartServiceController>(StartServiceController());

    // Home
    Get.put<HomeShowcaseController>(HomeShowcaseController());
    // Get.put<HomeController>(HomeController());
    Get.put<HomeShowcaseController>(HomeShowcaseController());

    // Notifications
    Get.put<NotificationsProvider>(NotificationsProvider());
    Get.put<NotificationsController>(NotificationsController());

    //More
    Get.lazyPut<MoreController>(() => MoreController());
    // BottomNavigation
    Get.put<BottomNavigationController>(BottomNavigationController());
  }
}
