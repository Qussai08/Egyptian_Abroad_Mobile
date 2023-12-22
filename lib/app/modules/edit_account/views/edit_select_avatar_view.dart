import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/select_avatar_grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/edit_account/controller/edit_account_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditSelectAvatarView extends StatelessWidget {
  EditSelectAvatarView({super.key});

  final _controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'تعديل الايقونة الخاصة بك.',
          style: Styles.getBoldStyle(
              color: Styles.black, fontSize: fixDpiFont(18)),
        ),
      )),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            SizedBox(height: 96.h),
            GestureDetector(
                child: SelectAvatarGridWidget(controller: _controller)),
            const Spacer(),
            Obx(() {
              return CustomButton(
                type: _controller.isDisabled.value
                    ? ButtonType.disabled
                    : ButtonType.primary,
                height: 50.h,
                width: 358.w,
                text: AppStrings.select.tr,
                onPressed: _controller.isDisabled.value
                    ? () {}
                    : () {
                        Get.toNamed(Routes.DATASAVED,
                            arguments: [_controller.selectedAvatarIndex, 1]);
                      },
              );
            }),
            SizedBox(height: 75.h),
          ],
        ),
      )),
    );
  }
}
