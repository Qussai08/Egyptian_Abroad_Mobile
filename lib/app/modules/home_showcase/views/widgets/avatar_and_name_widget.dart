import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';

import '../../../../core/theme/styles.dart';
import '../../controllers/home_showcase_controller.dart';
import 'custoum_showcase_widget.dart';
import 'profile_icon_widget.dart';

class AvatarAndNameWidget extends StatelessWidget {
  AvatarAndNameWidget({
    super.key,
  });

  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: fixDpiHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Avatar Image
              Showcase.withWidget(
                height: 146.h,
                width: 240.w,
                key: homeContoller.one,
                onTargetClick: () => log('onTargetClick'),
                targetShapeBorder: const CircleBorder(),
                targetBorderRadius: const BorderRadius.all(
                  Radius.circular(150),
                ),
                // disableDefaultTargetGestures: true,
                disposeOnTap: false,
                container: CustoumShowcase1Widget(),
                onBarrierClick: () {
                  log('onBarrierClick');
                },
                child: ProfileIconWidget(),
              ),

              SizedBox(width: 10.w),
              Text(
                "${AppStrings.hello.tr} ${homeContoller.authService.getUserProfile.shortName ?? ''} !",
                style: Styles.getBoldStyle(
                    color: Styles.black, fontSize: fixDpiFont(18)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
