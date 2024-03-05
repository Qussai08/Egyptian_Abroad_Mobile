import 'package:egyptians_abroad/app/modules/bottom_navigation.dart/controllers/bottom_navigation_controller.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:egyptians_abroad/app/modules/start_service/controllers/start_service_controller.dart';
import 'package:get/get.dart';

import '../../events/controllers/event_controller.dart';
import '../../events/data/providers/events_provider.dart';
import '../../home_showcase/controllers/home_showcase_controller.dart';
import '../../home_showcase/data/providers/favorites_list_provider.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../notifications/data/providers/notifications_provider.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Favorites
    Get.lazyPut<FavoritesListProvider>(() => FavoritesListProvider());
    Get.lazyPut<StartServiceController>(() => StartServiceController());

    // Home
    Get.put<HomeShowcaseController>(HomeShowcaseController());

    // Events
    // Get.put<EventsProvider>(EventsProvider());
    // Get.put<EventsController>(EventsController());
    Get.lazyPut<EventsProvider>(() => EventsProvider());
    Get.lazyPut<EventsController>(() => EventsController());

    // Notifications
    Get.lazyPut<NotificationsProvider>(() => NotificationsProvider());
    Get.lazyPut<NotificationsController>(() => NotificationsController());

    //More
    Get.lazyPut<MoreController>(() => MoreController());
    // BottomNavigation
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
