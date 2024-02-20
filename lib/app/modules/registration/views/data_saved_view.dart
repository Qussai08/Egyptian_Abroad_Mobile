import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/data_saved_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DataSavedView extends GetView<DataSavedController> {
  const DataSavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AvatarWidget(
                  backgroundColor: Styles.avatarsBackground[controller.data[0]],
                  imageAsset: AppImages.avatars[controller.data[0]],
                  imageScale: 0.5,
                  isSelected: true,
                  radius: 76.w,
                ),
                Positioned(
                    right: -10.0,
                    bottom: -10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(56)),
                      child: const Icon(
                        Icons.check_circle,
                        color: Styles.green,
                        size: 56,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 25.h),
            controller.data[1] == 0
                ? Text(AppStrings.welcome.tr,
                    style: Styles.getSemiBoldStyle(
                        color: Styles.black, fontSize: fixDpiFont(28)))
                : Container(),
            Text(
                controller.data[1] == 0
                    ? AppStrings.dataSavedSuccessfully.tr
                    : AppStrings.dataEditedSuccessfully.tr,
                style: Styles.getBoldStyle(
                    color: Styles.black, fontSize: fixDpiFont(18))),
          ],
        ),
      ),
    );
  }
}
