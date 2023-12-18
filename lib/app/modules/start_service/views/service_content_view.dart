import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/url_service_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class ServiceContentView extends StatefulWidget {
  final Category? category;
  final ServiceContent? serviceContent;
  const ServiceContentView({super.key, this.category, this.serviceContent});

  @override
  State<ServiceContentView> createState() => _ServiceContentViewState();
}

class _ServiceContentViewState extends State<ServiceContentView> {
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: Scaffold(
      //   resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [widget.category!.categoryColor!.toColor(), Colors.white],
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title: widget.serviceContent!.servicesContentTitle,
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: fixDpiScreenHeight() * 0.9,
                width: fixDpiScreenWidth(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.h),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.maleIcon,
                            width: 36.w,
                            fit: BoxFit.fitWidth,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TitleText(
                            title: "${AppStrings.hello.tr} احمد" "!",
                            fontSize: fixDpiFont(18),
                            color: const Color(0xff263238),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Image.network(
                      widget.category!.categoryIcon!,
                      width: 180.w,
                      height: 180.w,
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Align(
                      alignment: LocalizationHelper.isArabic()
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: html.Html(
                        data: widget.serviceContent!.servicesContentSummary!,
                        style: {
                          "*": html.Style(
                              color: const Color.fromRGBO(62, 60, 60, 0.71),
                              fontFamily: 'baloo',
                              fontSize: html.FontSize.large,
                              fontWeight: FontWeight.w400),
                          "div": html.Style(
                              color: const Color.fromRGBO(62, 60, 60, 0.71),
                              fontFamily: 'baloo',
                              fontSize: html.FontSize.large,
                              fontWeight: FontWeight.w400),
                          "span": html.Style(
                              color: const Color.fromRGBO(62, 60, 60, 0.71),
                              fontFamily: 'baloo',
                              fontSize: html.FontSize.large,
                              fontWeight: FontWeight.w400),
                          "p": html.Style(
                              color: const Color.fromRGBO(62, 60, 60, 0.71),
                              fontFamily: 'baloo',
                              fontSize: html.FontSize.large,
                              fontWeight: FontWeight.w400),
                          "a": html.Style(
                              color: Styles.primaryColor,
                              fontFamily: 'baloo',
                              fontSize: html.FontSize.large,
                              fontWeight: FontWeight.w400),
                        },
                        onLinkTap: (url, attributes, element) {
                          Get.to(() => URLServiceView(
                                url: url,
                              ));
                        },
                      ),
                      //     Text(
                      //   widget.serviceContent!.servicesContentSummary!,
                      //   textDirection: LocalizationHelper.isArabic()
                      //       ? TextDirection.rtl
                      //       : TextDirection.ltr,
                      //   style: TextStyle(
                      //       fontSize: fixDpiFont(16),
                      //       fontFamily: 'baloo',
                      //       fontWeight: FontWeight.w400,
                      //       color: const Color.fromRGBO(62, 60, 60, 0.71)),
                      // ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // TODO : add on press to open the url
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(() => URLServiceView(
                    //           url: widget.serviceContent!.serviceContentLink,
                    //         ));
                    //     // launchUrl(
                    //     //     mode: LaunchMode.platformDefault,
                    //     //     Uri.parse(
                    //     //         widget.serviceContent!.serviceContentLink!));
                    //   },
                    //   child: Align(
                    //     alignment: LocalizationHelper.isArabic()
                    //         ? Alignment.centerRight
                    //         : Alignment.centerLeft,
                    //     child: Text(
                    //       widget.serviceContent!.serviceContentLink!,
                    //       textDirection: TextDirection.ltr,
                    //       style: TextStyle(
                    //         fontSize: fixDpiFont(16),
                    //         fontFamily: 'baloo',
                    //         fontWeight: FontWeight.w400,
                    //         color: const Color(0xff1B57E3),
                    //         decoration: TextDecoration.underline,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const Spacer(),
                    CustomButton(
                      text: AppStrings.continueStr.tr,
                      icon: Icons.arrow_forward,
                      type: ButtonType.primary,
                      width: 300.w,
                      height: 50,
                      onPressed: () async {
                        Get.to(() => URLServiceView(
                              url: widget.serviceContent!.serviceContentLink,
                            ));
                        // await launchUrl(
                        //     mode: LaunchMode.platformDefault,
                        //     Uri.parse(
                        //         "https://www.google.com/maps/search/?api=1&query=-3.823216,-38.481700"));
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
                      text: AppStrings.backToApp.tr,
                      type: ButtonType.secondary,
                      width: 300.w,
                      height: 50,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                ),
              ),
            ),
          )),
    ));
  }
}
