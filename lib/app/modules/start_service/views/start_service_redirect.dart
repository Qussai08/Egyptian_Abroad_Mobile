import 'dart:developer';
import 'dart:io';

import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/service_content_view.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/url_service_view.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StartServiceRedir extends StatelessWidget {
  final ServiceContent serviceContent;
  final Category? category;

  const StartServiceRedir(
      {super.key, required this.serviceContent, this.category});

  @override
  Widget build(BuildContext context) {
    // serviceContent.servicesType != ServiceType.content
    // print("serviceContent.serviceName ${serviceContent.serviceName}");
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: fixDpiScreenWidth(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    width: fixDpiScreenWidth() * 0.4,
                    height: fixDpiScreenWidth() * 0.4,
                    padding: EdgeInsets.all(35.w),
                    child: Image.asset("assets/icons/service-redir.png"),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF9FBFF)),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    serviceContent.servicesType == ServiceType.web
                        ? "أنت على وشك فتح شاشة خدمة ${serviceContent.serviceName}، هل أنت متأكد من المتابعة؟"
                        : "برجاء العلم أنه سيتم تحويلك لتطبيق ${serviceContent.serviceName}. هل تريد المتابعة؟",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff3F3D56),
                        fontFamily: "baloo",
                        fontSize: fixDpiFont(15),
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  CustomButton(
                    text: "متابعة",
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 300.w,
                    height: 50,
                    onPressed: () async {
                      serviceContent.servicesType == ServiceType.web
                          ? Get.to(() => URLServiceView(
                                url: serviceContent.servicesLink,
                              ))
                          : await launchApp(
                              serviceContent.androidLink ??
                                  'com.facebook.katana',
                              serviceContent.iosLink ?? '284882215');
                      // launchUrl(
                      //     mode: LaunchMode.externalApplication,
                      //     Uri.parse("https://www.facebook.com"));
                      // Uri(
                      //     scheme: 'https',
                      //     host: 'www.google.com/maps/search/',
                      //     query: "?api=1&query=-3.823216,-38.481700"));
                      // Get.toNamed(
                      //   Routes.STARTSERVICE,
                      // );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    text: "الرجوع إلي التطبيق",
                    type: ButtonType.secondary,
                    width: 300.w,
                    height: 50,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  launchApp(String androidID, String iosID) {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? androidID : iosID;
      // 'com.mcit.eca' : '6444364022';
      final url = androidID == iosID
          ? Uri.parse(iosID)
          : Uri.parse(
              Platform.isAndroid
                  ? "market://details?id=$appId"
                  : "https://apps.apple.com/app/id$appId",
            );

      print("url : ${url}");

      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
