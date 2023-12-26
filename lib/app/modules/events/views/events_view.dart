import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
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
                      Get.bottomSheet(Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: const BoxDecoration(
                                color: Color(0xffE7F2F4),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                            height: 68.h,
                            child: Row(children: [
                              Container(
                                width: fixDpiFont(24),
                              ),
                              Spacer(),
                              Text(
                                "بحث باستخدام",
                                style: Styles.getMediumStyle(
                                    color: Color(0xff201D61), fontSize: 24),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Icon(
                                  Icons.close,
                                  size: fixDpiFont(24),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              children: [
                                TextFieldTitle(
                                  title: "تاريخ بدء الفعالية",
                                  hasSubTitle: false,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(37)),
                                      border:
                                          Border.all(color: Color(0xffEBEBEB))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.from.tr,
                                        style: Styles.getMediumStyle(
                                            color: Styles.lightBlack,
                                            fontSize: fixDpiFont(12)),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.calendar_month,
                                        color: Styles.lightBlack,
                                        size: fixDpiFont(12),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text("21 ديسمبر 2023  7:00 ص",
                                          style: Styles.getMediumStyle(
                                              color: Styles.lightBlack,
                                              fontSize: fixDpiFont(12))),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17.w),
                                        child: Container(
                                          color: Color(0xffEBEBEB),
                                          width: 1,
                                        ),
                                      ),
                                      Text(AppStrings.to.tr,
                                          style: Styles.getMediumStyle(
                                              color: Styles.lightBlack,
                                              fontSize: fixDpiFont(12))),
                                      SizedBox(width: 4.w),
                                      Icon(Icons.calendar_month,
                                          color: Styles.lightBlack,
                                          size: fixDpiFont(12)),
                                      SizedBox(width: 4.w),
                                      Text("21 ديسمبر 2023  7:00 ص",
                                          style: Styles.getMediumStyle(
                                              color: Styles.lightBlack,
                                              fontSize: fixDpiFont(12))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                TextFieldTitle(
                                  title: "دولة الفعالية",
                                  hasSubTitle: false,
                                ),
                                DropDownListSelector(dropDownList: []),
                                SizedBox(height: 16.h),
                                TextFieldTitle(
                                  title: "موضوع الفعالية",
                                  hasSubTitle: false,
                                ),
                                DropDownListSelector(dropDownList: []),
                                SizedBox(height: 30.h),
                                CustomButton(
                                  type: ButtonType.primary,
                                  text: "إظهار النتائج",
                                )
                              ],
                            ),
                          ),
                        ]),
                      ));
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
