import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home/controllers/home_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileIconWidget extends StatelessWidget {
  const ProfileIconWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AvatarWidget(
        radius: 18.w,
        imageScale: 2.0,
        backgroundColor: Styles.avatarsBackground[
            controller.authService.getUserProfile!.avatarId!],
        imageAsset:
            AppImages.avatars[controller.authService.getUserProfile!.avatarId!],
        isSelected: false);
  }
}
