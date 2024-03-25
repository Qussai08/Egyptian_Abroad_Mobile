import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/start_service/views/url_service_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language/app_string.dart';
import '../controllers/start_service_controller.dart';

class StartServiceRedir extends GetView<StartServiceController> {
  final ServiceContent serviceContent;
  final Category? category;

  const StartServiceRedir(
      {super.key, required this.serviceContent, this.category});

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(),
            body: Container(
              width: fixDpiScreenWidth(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    width: fixDpiScreenWidth() * 0.4,
                    height: fixDpiScreenWidth() * 0.4,
                    padding: EdgeInsets.all(35.w),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF9FBFF)),
                    child: Image.asset("assets/icons/service-redir.png"),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    // TODO : translate
                    serviceContent.servicesType == ServiceType.web
                        ? "برجاء العلم أنه سيتم تحويلك لموقع \"${serviceContent.serviceName}\"، هل تريد المتابعة؟"
                        : "أنت على وشك فتح شاشة خدمة \"${serviceContent.serviceName}\". هل تريد المتابعة؟",
                    textAlign: TextAlign.center,
                    style: Styles.getSemiBoldStyle(
                        color: Styles.blueGrey, fontSize: fixDpiFont(15)),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: AppStrings.continueStr.tr,
                    icon: Icons.arrow_forward,
                    type: ButtonType.primary,
                    width: 300.w,
                    height: 50,
                    onPressed: () async {
                      serviceContent.servicesType == ServiceType.web
                          ? Get.to(() => URLServiceView(
                                url: serviceContent.servicesLink,
                              ))
                          : await controller.launchApp(
                              appLink: serviceContent.appLink ?? "",
                              androidID: serviceContent.androidLink ?? "",
                              iosID: serviceContent.iosLink ?? "");
                    },
                  ),
                  SizedBox(
                    height: 66.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
