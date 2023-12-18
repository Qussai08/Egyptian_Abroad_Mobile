import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';
import '../data/providers/notifications_provider.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationsProvider>(NotificationsProvider());
    Get.put<NotificationsController>(NotificationsController());
  }
}
