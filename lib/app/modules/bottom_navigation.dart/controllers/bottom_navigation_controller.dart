import 'package:egyptians_abroad/app/modules/events/views/events_view.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/home_showcase_view.dart';
import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:egyptians_abroad/app/modules/notifications/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../events/controllers/event_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0;

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
}
