import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home_showcase_controller.dart';

class ProfileIconWidget extends StatelessWidget {
  ProfileIconWidget({
    super.key,
  });

  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ViewACCOUNT);
      },
      child: AvatarWidget(
          radius: 18.w,
          imageScale: 2.0,
          backgroundColor: Styles.avatarsBackground[
              homeContoller.authService.getUserProfile?.avatarId ?? 0],
          imageAsset: AppImages
              .avatars[homeContoller.authService.getUserProfile?.avatarId ?? 0],
          isSelected: false),
    );
  }
}
