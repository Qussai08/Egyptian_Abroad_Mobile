import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/events/controllers/event_controller.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/custom_widgets/app_error_widget.dart';
import '../../../core/custom_widgets/custom_textfield.dart';
import '../../../core/custom_widgets/loading_dialog.dart';
import '../../../core/custom_widgets/title_text.dart';
import '../../../core/theme/styles.dart';
import 'widgets/from_to_date_widget.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(EventsController());
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, fixDpiHeight(110)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, -0.02),
                end: Alignment(-1, 0.02),
                colors: [Color(0xFF726CFD), Color(0xFF2665F7)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // space
                SizedBox(height: fixDpiHeight(20)),
                // title
                TitleText(
                  title: AppStrings.events.tr,
                  color: Styles.white,
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(
                  right: 16.w, left: 8.w, top: 12.h, bottom: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.blackShadow,
                            blurRadius: 45,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: CustomTextFormField(
                          controller: controller.searchController,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Styles.primaryColor,
                          ),
                          inputData: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onChangedFunc: (val) {},
                          onFieldSubmitted: (val) {},
                          hintTxt: AppStrings.search.tr,
                          hintStyle:
                              Styles.getRegularStyle(color: Styles.lightBlack)
                          // TextStyle(
                          //     fontSize: fixDpiFont(14),
                          //     fontWeight: FontWeight.w400,
                          //     fontFamily: 'baloo'),
                          ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //  Get.bottomSheet(Container(height: 400,,));
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.blackShadow,
                            blurRadius: 45,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppImages.filterIcon,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.EVENT_DETAILS);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 12.h, right: 16.w, left: 16.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Styles.blackShadow,
                              blurRadius: 45,
                              offset: Offset(10, 10),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          titleTextStyle: Styles.getBoldStyle(
                              color: Styles.black2, fontSize: 16),
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("مؤتمر إتحاد الجاليات المصرية بالخارج"),
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                  color: Color(0xff3F3D56),
                                  weight: 20,
                                )
                              ],
                            ),
                          ),
                          subtitle: const FromToDateWidget(
                              fromDate: '21 ديسمبر 2023  7:00 ص',
                              toDate: '21 ديسمبر 2023  7:00 ص'),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
