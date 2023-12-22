import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectAvatarGridWidget extends StatelessWidget {
  const SelectAvatarGridWidget({
    super.key,
    required this.controller,
  });

  final RegistrationController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 47.w,
          mainAxisSpacing: 49.h,
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Obx(() {
            return AvatarWidget(
              backgroundColor: Styles.avatarsBackground[index],
              imageAsset: AppImages.avatars[index],
              isSelected:
                  controller.avatarsProvider.avatars[index].isSelected(),
              onTap: () {
                controller.selectAvatar(index);
              },
            );
          });
        });
  }
}
