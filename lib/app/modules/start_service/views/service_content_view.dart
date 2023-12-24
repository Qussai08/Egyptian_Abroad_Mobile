import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
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
    AuthService authService = Get.find();
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
              title: Text(
                widget.serviceContent!.servicesContentTitle ?? "",
                style: Styles.getBoldStyle(
                    color: Styles.black, fontSize: fixDpiFont(26)),
              ),
            ),
            body: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: fixDpiScreenHeight() * 0.9,
                ), // Set the minimum height

                child: Container(
                  width: fixDpiScreenWidth(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
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
                              data: widget
                                  .serviceContent!.servicesContentSummary!,
                              style: {
                                "*": html.Style(
                                    color:
                                        const Color.fromRGBO(62, 60, 60, 0.71),
                                    fontFamily: 'baloo',
                                    fontSize: html.FontSize.large,
                                    fontWeight: FontWeight.w400),
                                "div": html.Style(
                                    color:
                                        const Color.fromRGBO(62, 60, 60, 0.71),
                                    fontFamily: 'baloo',
                                    fontSize: html.FontSize.large,
                                    fontWeight: FontWeight.w400),
                                "span": html.Style(
                                    color:
                                        const Color.fromRGBO(62, 60, 60, 0.71),
                                    fontFamily: 'baloo',
                                    fontSize: html.FontSize.large,
                                    fontWeight: FontWeight.w400),
                                "p": html.Style(
                                    color:
                                        const Color.fromRGBO(62, 60, 60, 0.71),
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
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomButton(
                            text: AppStrings.continueStr.tr,
                            icon: Icons.arrow_forward,
                            type: ButtonType.primary,
                            width: 300.w,
                            height: 50,
                            onPressed: () async {
                              Get.to(() => URLServiceView(
                                    url: widget
                                        .serviceContent!.serviceContentLink,
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 76.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}
