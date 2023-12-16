import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'dart:async';
import 'dart:convert';

import 'package:egyptians_abroad/app/core/helper/secure_storage_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/login/controllers/login_controller.dart';
import 'package:egyptians_abroad/app/modules/login/views/login_view.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
    // _delay();
  }

  // Future<Null> _delay() async {
  //   await Future.delayed(const Duration(
  //     milliseconds: 3000,
  //   )).then((value) {
  //     Get.offAllNamed(Routes.LOGIN); // For now ;)
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    Timer(const Duration(seconds: 3), () async {
      var userData = await SecureStorageHelper.localRead('user');
      print("userData $userData");
      if (userData != null) {
        var json = jsonDecode(userData);
        final controller = Get.put(LoginController());

        controller.login(email: json['email'], pass: json['password']);
      } else {
        Get.offAllNamed(Routes.LOGIN);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => LoginView()),
        //     (route) => false);
      }
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
              margin: EdgeInsets.only(left: 25.w, top: 10),
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
