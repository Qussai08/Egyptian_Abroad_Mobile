import 'package:egyptians_abroad/app/core/custom_widgets/technical_partner_widget.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/more/views/widgets/list_tile_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
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
      body: Column(
        children: [
          ListTileWidget(
              text: AppStrings.profile.tr,
              imageAsset: AppImages.profileIcon,
              onTap: () => controller.changeView(Routes.ViewACCOUNT)),
          const Divider(color: Styles.grey_200, height: 0),
          ListTileWidget(
              text: AppStrings.aboutUs.tr,
              imageAsset: AppImages.logo,
              imageScale: 12,
              onTap: () => controller.changeView(Routes.ABOUTUS)),
          const Divider(color: Styles.grey_200, height: 0),
          ListTileWidget(
              text: AppStrings.contactUs.tr,
              imageAsset: AppImages.callIcon,
              onTap: () => controller.changeView(Routes.CONTACTUS),
              imageScale: 2),
          const Divider(color: Styles.grey_200, height: 0),
          Visibility(
            visible: false, // hide change language button

            child: ListTileWidget(
              imageAsset: AppImages.languageIcon,
              text: AppStrings.language.tr,
            ),
          ),
          const Divider(color: Styles.grey_200, height: 0),
          ListTileWidget(
            text: AppStrings.logOut.tr,
            imageAsset: AppImages.logoutIcon,
            onTap: () {
              controller.onLogout();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
          const Divider(color: Styles.grey_200, height: 0),
          const Spacer(),
        ],
      ),
    );
  }
}
