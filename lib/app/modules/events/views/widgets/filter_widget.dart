import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/custom_widgets/dropdown_list_selector.dart';
import '../../../../core/custom_widgets/textfield_title.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/helper/localization_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/app_images.dart';
import '../../../../core/theme/styles.dart';
import '../../../notifications/data/models/notifications_model/notifications_model.dart';
import '../../../registration/data/models/country.dart';
import '../../../registration/data/models/job_category.dart';
import '../../controllers/event_controller.dart';
import '../../data/models/event_model.dart';
import 'country_filter.dart';
import 'filter_date_widget.dart';
import 'filter_dates_error_widget.dart';
import 'job_category_filter.dart';

class FilterWidget extends GetView<EventsController> {
  const FilterWidget(
      {super.key,
      required this.jobCatSearchFocusNode,
      required this.countrySearchFocusNode,
      required this.con});

  final FocusNode jobCatSearchFocusNode;
  final FocusNode countrySearchFocusNode;
  final EventsController con;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    topRight: Radius.circular(12),
                  ),
                ),
                height: 68.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.clear();
                            controller.clearFilters();

                            // controller.filterEvents(closeBottomSheet: false);
                          },
                          child: Icon(
                            Icons.restart_alt,
                            size: fixDpiFont(24),
                          ),
                        ),
                        Text(
                          "بحث باستخدام",
                          style: Styles.getMediumStyle(
                              color: Color(0xff201D61),
                              fontSize: fixDpiFont(24)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Icon(
                              Icons.close,
                              size: fixDpiFont(24),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    const TextFieldTitle(
                      title: "تاريخ بدء الفعالية",
                      hasSubTitle: false,
                    ),
                    FilterWithDateWidget(con: con),
                    FilterDatesErrorWidget(),
                    SizedBox(height: 12.h),
                    const TextFieldTitle(
                      title: "دولة الفعالية",
                      hasSubTitle: false,
                    ),
                    FilterWithCountryWidget(
                      controller: controller,
                      countrySearchFocusNode: countrySearchFocusNode,
                    ),
                    SizedBox(height: 12.h),
                    const TextFieldTitle(
                      title: "موضوع الفعالية",
                      hasSubTitle: false,
                    ),
                    FilterWithJobCatWidget(
                      controller: controller,
                      jobCatSearchFocusNode: jobCatSearchFocusNode,
                    ),
                    SizedBox(height: 15.h),
                    CustomButton(
                      type: ButtonType.primary,
                      text: "إظهار النتائج",
                      onPressed: () async {
                        controller.clear();
                        await controller.filterEvents();
                      },
                    )
                  ],
                ),
              ),
            ]),
          ));
        });
  }
}
