import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash.png"),
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
                    'assets/images/logo.png',
                    width: 90.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    AppStrings.appName.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w700,
                        color: Styles.black,
                        fontFamily: 'baloo'),
                  ),
                  Container(
                    width: 150.w,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppStrings.splashDiscription.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.blueBlack,
                          fontFamily: 'baloo'),
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
