import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/dpi_helper.dart';
import '../../../core/theme/app_images.dart';

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
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 25.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                              color: Styles.blueBlack,
                              fontSize: fixDpiFont(11)),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 80.w),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Styles.blackShadow,
                          blurRadius: 45,
                          offset: Offset(10, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      "v1.2.4",
                      style: Styles.getMediumStyle(
                          color: Styles.black3.withOpacity(0.9), fontSize: 17),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
