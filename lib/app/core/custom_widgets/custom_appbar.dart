import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});
  final String? title;
  // final void Function()? onBack;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style:
            Styles.getBoldStyle(color: Styles.black, fontSize: fixDpiFont(26)),
      ),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset(
            AppImages.backIcon,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      actions: [
        Container(
          width: 24.w,
        )
      ],
      centerTitle: true,
    );
  }
}
