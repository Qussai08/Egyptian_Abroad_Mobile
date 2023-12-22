import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0), // here the desired height
        child: Container(
          height: 4,
          color: Styles.primaryColor,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Image.asset(
              AppImages.travel,
              width: 40.h,
              height: 40.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            " ${AppStrings.appName.tr}",
            textAlign: TextAlign.center,
            style: Styles.getBoldStyle(
                color: Styles.black, fontSize: fixDpiFont(16)),
          ),
        ],
      ),
      // leading: Container(
      //   margin: const EdgeInsets.only(right: 10),
      //   child: Image.asset(
      //     'assets/icons/masr-dig.png',
      //     width: 65.w,
      //     fit: BoxFit.fitWidth,
      //   ),
      // ),
      // actions: [
      //   Container(
      //     width: 65.w,
      //   )
      // ],
      centerTitle: true,
    );
  }
}
