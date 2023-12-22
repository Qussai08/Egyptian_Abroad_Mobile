import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.toolbarHeight});
  final Widget? title;
  final double? toolbarHeight;
  // final void Function()? onBack;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: title,
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Image.asset(
          AppImages.backIcon,
          // width: 24.w,
          // height: 24.w,
          // fit: BoxFit.fitWidth,
        ),

        //  Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 10),
        //   child:
        // ),
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
