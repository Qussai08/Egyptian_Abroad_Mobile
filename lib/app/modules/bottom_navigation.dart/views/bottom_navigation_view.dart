import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/bottom_navigation.dart/controllers/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: SafeArea(
        child: GetBuilder<BottomNavigationController>(
          builder: (bottomNavigationController) => Scaffold(
            body: bottomNavigationController.selectedContent,
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                _buildNavigationBarItem(
                  label: AppStrings.home.tr,
                  tabIcon: AppImages.homeIcon,
                ),
                _buildNavigationBarItem(
                  label: AppStrings.notifications.tr,
                  tabIcon: AppImages.notificationIcon,
                ),
                _buildNavigationBarItem(
                  label: AppStrings.more.tr,
                  tabIcon: AppImages.moreIcon,
                ),
                // _buildNavigationBarItem(
                //   label: 'start service',
                //   tabIcon: AppImages.homeIcon,
                // ),
              ],
              currentIndex: bottomNavigationController.tabIndex,
              selectedItemColor: Styles.primaryColor,
              unselectedItemColor: const Color(0xFF404554),
              selectedLabelStyle: TextStyle(
                  fontSize: fixDpiFont(10),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'baloo'),
              unselectedLabelStyle: TextStyle(
                  fontSize: fixDpiFont(10),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'baloo'),
              onTap: (int index) {
                bottomNavigationController.changeTabIndex(index);
              },
              elevation: 5,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      {required String label, required String tabIcon}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        tabIcon,
        color: const Color(0xFF404554),
        width: 24,
        height: 24,
      ),
      activeIcon: Container(
        padding: const EdgeInsets.only(top: 3),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
              width: 3, style: BorderStyle.solid, color: Styles.primaryColor),
        )),
        child: Image.asset(
          tabIcon,
          color: Styles.primaryColor,
          width: 24,
          height: 24,
        ),
      ),
      label: label,
    );
  }
}
