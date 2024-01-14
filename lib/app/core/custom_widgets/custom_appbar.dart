import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.toolbarHeight,
      this.backButtonImageAsset,
      this.actionAsset,
      this.actionsEnabled = false,
      this.leadingEnabled = true,
      this.onBack,
      this.onClose});
  final Widget? title;
  final double? toolbarHeight;
  final String? backButtonImageAsset;
  final String? actionAsset;
  final bool? actionsEnabled;
  final bool? leadingEnabled;
  final void Function()? onBack;
  final void Function()? onClose;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: title,
      actions: actionsEnabled!
          ? [
              TextButton(
                  onPressed: () {
                    onClose ?? Get.close(2);
                  },
                  child: Image.asset(
                    actionAsset ?? AppImages.closeIcon,
                  )),
            ]
          : null,
      leading: leadingEnabled!
          ? TextButton(
              onPressed: () {
                onBack ?? Get.back();
              },
              child: Image.asset(
                backButtonImageAsset ?? AppImages.backIcon,
              ),
            )
          : Container(),
      centerTitle: true,
    );
  }
}
