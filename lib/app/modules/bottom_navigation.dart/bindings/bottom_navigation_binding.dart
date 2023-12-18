import 'package:egyptians_abroad/app/modules/bottom_navigation.dart/controllers/bottom_navigation_controller.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../notifications/data/providers/notifications_provider.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Home
    Get.put<HomeController>(HomeController());

    // Notifications
    Get.put<NotificationsProvider>(NotificationsProvider());
    Get.put<NotificationsController>(NotificationsController());

    //More
    Get.lazyPut<MoreController>(() => MoreController());
    // BottomNavigation
    Get.put<BottomNavigationController>(BottomNavigationController());
  }
}
