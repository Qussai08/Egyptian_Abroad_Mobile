import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/column_element_widget.dart';
import 'widgets/custom_card_widget.dart';
import 'widgets/header_widget.dart';
import 'package:flutter/material.dart';

class ContactUsView extends GetView<MoreController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          controller.changeView(const MoreListView());
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            HeaderWidget(
                imageAsset: AppImages.callIcon, text: AppStrings.contactUs.tr),
            SizedBox(height: 64.h),
            CustomCardWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.callUsVia.tr,
                  style: Styles.getRegularStyle(
                      color: Styles.lightBlack, fontSize: fixDpiFont(16)),
                ),
                SizedBox(height: 16.h),
                ContactElementWidget(
                  imageAsset: AppImages.callIcon,
                  imageScale: 2,
                  text: '0225864252',
                  fontSize: fixDpiFont(14),
                ),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    imageAsset: AppImages.facebookIcon,
                    text: 'facebook/eme',
                    fontSize: fixDpiFont(14)),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    imageAsset: AppImages.gmailIcon,
                    text: 'emigration@gov.eg',
                    fontSize: fixDpiFont(14)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
