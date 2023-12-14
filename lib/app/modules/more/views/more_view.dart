import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/custom_widgets/title_text.dart';
import '../../../core/helper/dpi_helper.dart';
import '../../../core/language/app_string.dart';
import '../../../core/theme/styles.dart';
import '../controllers/more_controller.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, fixDpiHeight(110)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.00, -0.02),
              end: Alignment(-1, 0.02),
              colors: [Color(0xFF726CFD), Color(0xFF2665F7)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // space
              SizedBox(height: fixDpiHeight(20)),
              // title
              TitleText(
                title: AppStrings.more.tr,
                color: Styles.white,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // space
          SizedBox(height: fixDpiHeight(15)),
          // Obx(() {
          //   if (controller.notificationsList.isEmpty) {
          //     return const Center(child: Text('No notifications'));
          //   }
          //   return ListView.builder(
          //     physics: const ClampingScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: controller.notificationsList.length,
          //     itemBuilder: (context, index) {
          //       final notification = controller.notificationsList[index];

          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: fixDpiWidth(16)),
          //         child: NotificationCardWidget(notification: notification),
          //       );
          //     },
          //   );
          // }),

          // space
          SizedBox(height: fixDpiHeight(28)),
        ],
      ),
    );
  }
}
