import 'package:egyptians_abroad/app/modules/bottom_navigation.dart/controllers/bottom_navigation_controller.dart';
import 'package:get/get.dart';

import '../../notifications/controllers/notifications_controller.dart';
import '../../notifications/data/providers/notifications_provider.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Notifications
    Get.put<NotificationsProvider>(NotificationsProvider());
    Get.put<NotificationsController>(NotificationsController());

    // BottomNavigation
    Get.put<BottomNavigationController>(BottomNavigationController());
  }
}
