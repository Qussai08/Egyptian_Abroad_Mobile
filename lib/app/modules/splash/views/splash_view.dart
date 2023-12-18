import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/dpi_helper.dart';
import '../../../core/language/app_string.dart';
import '../../../core/theme/app_images.dart';
import '../../../core/theme/styles.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 25.w),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: 90.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    AppStrings.appName.tr,
                    textAlign: TextAlign.center,
                    style: Styles.getBoldStyle(
                        color: Styles.black, fontSize: fixDpiFont(21)),
                  ),
                  Container(
                    width: 150.w,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppStrings.splashDiscription.tr,
                      textAlign: TextAlign.center,
                      style: Styles.getRegularStyle(
                          color: Styles.blueBlack, fontSize: fixDpiFont(11)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
