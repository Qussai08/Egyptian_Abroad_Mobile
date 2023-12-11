import 'package:egyptians_abroad/app/modules/home/views/home_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/start_service_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var tabIndex = 0;

  final List<Widget> _navigationScreens = [HomeView(), URLServiceView()];

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Widget get selectedContent {
    return _navigationScreens[tabIndex];
  }
}
