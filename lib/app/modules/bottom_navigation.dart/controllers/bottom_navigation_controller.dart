import 'package:egyptians_abroad/app/modules/home/views/home_view.dart';
import 'package:egyptians_abroad/app/modules/notifications/views/notifications_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/url_service_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../notifications/controllers/notifications_controller.dart';

class BottomNavigationController extends GetxController {
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();
  var tabIndex = 0;

  final List<Widget> _navigationScreens = [
    const HomeView(),
    const NotificationsView(),
    const URLServiceView()
  ];

  void changeTabIndex(int index) {
    tabIndex = index;
    if (index == 1) {
      getNotifications();
    }
    update();
  }

  Widget get selectedContent {
    return _navigationScreens[tabIndex];
  }

  // call notification api
  getNotifications() {
    notificationsController.loadNotifications();
  }
}
