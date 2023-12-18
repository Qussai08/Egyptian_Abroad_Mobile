import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/custom_card_widget.dart';
import 'widgets/header_widget.dart';
import 'package:flutter/material.dart';

class AboutUsView extends GetView<MoreController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            HeaderWidget(
                imageAsset: AppImages.mediumLogo, text: AppStrings.aboutUs.tr),
            SizedBox(height: 64.h),
            CustomCardWidget(
              child: Text(
                'هذا نص توضيحى يستخدم لاغراض التصميم هذا نص هذا نص توضيحى يستخدم لاغراض التصميم هذا نص هذا نص توضيحى يستخدم لاغراض التصميم هذا نص هذا نص توضيحى يستخدم لاغراض التصميم هذا نص هذا نص توضيحى يستخدم لاغراض التصميم هذا نص',
                style: Styles.getSemiBoldStyle(
                  color: Styles.mediumBlack,
                  fontSize: fixDpiFont(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
