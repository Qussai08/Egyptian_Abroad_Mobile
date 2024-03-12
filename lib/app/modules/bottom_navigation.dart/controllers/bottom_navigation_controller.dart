import 'package:egyptians_abroad/app/core/constants/storage_constants.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_dialog.dart';
import 'package:egyptians_abroad/app/core/services/storage_service.dart';
import 'package:egyptians_abroad/app/modules/events/views/events_view.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/home_showcase_view.dart';
import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:egyptians_abroad/app/modules/notifications/views/notifications_view.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../events/controllers/event_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null) {
      changeTabIndex(Get.arguments[1]);
    }
    // checkIsNotified();
  }

  final List<Widget> _navigationScreens = [
    const HomeShowcaseView(),
    const NotificationsView(),
    const EventsView(),
    const MoreView(),
  ];

  void changeTabIndex(int index) {
    if (tabIndex != index) {
      tabIndex = index;
      if (index == 1) {
        getNotifications();
      } else {
        if (Get.arguments != null) {
          Get.arguments[0] = -1;
        }
      }
      if (index == 2) {
        getEvents();
      } else {
        disposeEvents();
      }
      update();
    }
  }

  Widget get selectedContent {
    return _navigationScreens[tabIndex];
  }

  // call notification api
  getNotifications() {
    final NotificationsController notificationsController =
        Get.find<NotificationsController>();
    notificationsController.openNotificationId =
        (Get.arguments != null) ? Get.arguments[0] : -1;

    notificationsController.loadNotifications();
  }

// TODO : load events
  getEvents() {
    final EventsController eventsController = Get.find<EventsController>();

    eventsController.loadEvents();
  }

  disposeEvents() {
    final EventsController eventsController = Get.find<EventsController>();
    eventsController.clear();
    eventsController.clearFilters();
    // eventsController.dispose();
  }

  checkIsNotified() {
    final storageService = Get.find<StorageService>();

    var notificationId =
        storageService.getData(StorageConstants.kNotificationId);

    print('CheckIsNotified NotificationId: $notificationId');
    if (notificationId != null) {
      storageService.setData(StorageConstants.kNotificationId, null);
      // changeTabIndex(1);
      Get.offAllNamed(Routes.BOTTOMNAVIGATION,
          arguments: [int.parse(notificationId), 1]);
      // notificationId = null;
    }
  }
}
