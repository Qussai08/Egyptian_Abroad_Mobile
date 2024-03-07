import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
            child: Image.asset(
              AppImages.travel,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.fitHeight,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: SvgPicture.asset(
              AppImages.logoName,
              width: 102.w,
              alignment: Alignment.topCenter,
            ),
          ),
          // Text(
          //   " ${AppStrings.appName.tr}",
          //   textAlign: TextAlign.center,
          //   style: Styles.getBoldStyle(
          //       color: Styles.black, fontSize: fixDpiFont(16)),
          // ),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(right: 12.5.w),
        child: Image.asset(AppImages.technicalPartner),
      ),
      centerTitle: true,
    );
  }
}
