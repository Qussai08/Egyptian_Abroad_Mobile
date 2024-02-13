import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/select_avatar_grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegistrationSelectAvatarView extends GetView<RegistrationController> {
  const RegistrationSelectAvatarView({super.key, this.carRegister = false});
  final bool carRegister;

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                height: fixDpiScreenHeight(),
                width: fixDpiScreenWidth(),
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Form(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.user,
                        width: 56.w,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppStrings.completeAccountTitle.tr,
                        style: Styles.getBoldStyle(
                            color: Styles.black, fontSize: fixDpiFont(24)),
                      ),
                      SizedBox(height: 32.h),
                      Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              !carRegister
                                  ? const ProgressIndicatorWidget(step: '3')
                                  : const ProgressIndicatorWidget(
                                      step: '4',
                                      total: '4',
                                    ),
                              SizedBox(width: 8.h),
                              Text(
                                'اختر الايقونة الخاصة بك.',
                                style: Styles.getBoldStyle(
                                    color: Styles.black,
                                    fontSize: fixDpiFont(17)),
                              ),
                            ],
                          )),
                      SizedBox(height: 30.h),
                      SelectAvatarGridWidget(controller: controller),
                      SizedBox(height: 40.h),
                      Obx(() {
                        return CustomButton(
                          type: controller.isDisabled.value
                              ? ButtonType.disabled
                              : ButtonType.primary,
                          text: AppStrings.save.tr,
                          height: 50.h,
                          width: 358.w,
                          onPressed: () async {
                            await controller.pushAvatar(
                                avatar: controller.selectedAvatarIndex,
                                route: 0);
                          },
                        );
                      }),
                      SizedBox(height: 24.h),
                      CustomButton(
                        type: ButtonType.secondary,
                        text: AppStrings.skip.tr,
                        height: 50.h,
                        width: 358.w,
                        onPressed: () async {
                          controller.selectedAvatarIndex = 9;
                          await controller.pushAvatar(
                              avatar: controller.selectedAvatarIndex, route: 0);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
