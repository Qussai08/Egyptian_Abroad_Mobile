import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/more/views/about_us_view.dart';
import 'package:egyptians_abroad/app/modules/more/views/contact_us_view.dart';
import 'package:egyptians_abroad/app/modules/more/views/widgets/column_element_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Obx(() => Container(child: controller.content()));
  }
}

class MoreListView extends GetView<MoreController> {
  const MoreListView({
    super.key,
  });

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
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              height: 73.h,
              child: ContactElementWidget(
                  imageAsset: AppImages.profileIcon,
                  text: AppStrings.profile.tr,
                  fontSize: fixDpiFont(16)),
            ),
          ),
          const Divider(color: Styles.grey_200),
          InkWell(
            onTap: () {
              controller.changeView(const AboutUsView());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              height: 71.h,
              child: ContactElementWidget(
                  imageAsset: AppImages.logo,
                  imageScale: 12,
                  text: AppStrings.aboutUs.tr,
                  fontSize: fixDpiFont(16)),
            ),
          ),
          const Divider(color: Styles.grey_200),
          InkWell(
            onTap: () {
              controller.changeView(const ContactUsView());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              height: 71.h,
              child: ContactElementWidget(
                  imageAsset: AppImages.callIcon,
                  imageScale: 2,
                  text: AppStrings.contactUs.tr,
                  fontSize: fixDpiFont(16)),
            ),
          ),
          // const Divider(color: Styles.grey_200),
          Visibility(
            visible: false, // hide change language button
            child: InkWell(
              onTap: () {
                // const ChangeLangButtonWidget();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                height: 71.h,
                child: ContactElementWidget(
                    imageAsset: AppImages.languageIcon,
                    text: AppStrings.language.tr,
                    fontSize: fixDpiFont(16)),
              ),
            ),
          ),
          const Divider(color: Styles.grey_200),
        ],
      ),
    );
  }
}
