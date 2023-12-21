import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectAvatar extends GetView<RegistrationController> {
  const SelectAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height

          child: CustomAppBar(
            toolbarHeight: 100,
            title: Column(
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
              ],
            ),
          ),
        ),
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
                      SizedBox(height: 41.h),
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'اختر الايقونة الخاصة بك.',
                            style: Styles.getBoldStyle(
                                color: Styles.black, fontSize: fixDpiFont(17)),
                          )),
                      SizedBox(height: 41.h),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 47.w,
                            mainAxisSpacing: 49.h,
                            crossAxisCount: 3,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return AvatarWidget(
                                backgroundColor:
                                    Styles.avatarsBackground[index],
                                imageAsset: AppImages.avatars[index],
                                isSelected: controller
                                    .avatarsProvider.avatars[index]
                                    .isSelected(),
                                onTap: () {
                                  controller.selectAvatar(index);
                                },
                              );
                            });
                          }),
                      SizedBox(height: 120.h),
                      CustomButton(
                        text: AppStrings.save.tr,
                        height: 50.h,
                        width: 358.w,
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        type: ButtonType.disabled,
                        text: AppStrings.skip.tr,
                        height: 50.h,
                        width: 358.w,
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
