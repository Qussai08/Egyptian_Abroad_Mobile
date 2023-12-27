import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/dropdown_list_selector.dart';
import '../../../../core/custom_widgets/textfield_title.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/app_images.dart';
import '../../../../core/theme/styles.dart';
import '../../../notifications/data/models/notifications_model/notifications_model.dart';
import '../../../registration/data/models/country.dart';
import '../../../registration/data/models/job_category.dart';
import '../../controllers/event_controller.dart';

class FilterWidget extends GetView<EventsController> {
  const FilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventsController con = Get.find();

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
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
                    GetBuilder<EventsController>(
                        builder: (eventsController) => Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                  border: Border.all(color: Color(0xffEBEBEB))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime _dateTime = DateTime.now();

                                      await showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (_) {
                                            final size =
                                                MediaQuery.of(context).size;

                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              height: size.height * 0.27,
                                              width: fixDpiScreenWidth(),
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                onDateTimeChanged:
                                                    (DateTime pickedDate) {
                                                  String formattedDate = DateFormat(
                                                          'yyyy-MM-dd HH:mm:ss')
                                                      .format(pickedDate);

                                                  con.setDateFrom(
                                                      formattedDate);
                                                },
                                                minimumDate: DateTime(
                                                  2023,
                                                  12,
                                                  20,
                                                ),
                                                maximumDate: DateTime(
                                                  2025,
                                                  12,
                                                  20,
                                                ),
                                                initialDateTime: _dateTime,
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
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
                                        Container(
                                          width: 130,
                                          child: Text(
                                              eventsController.dateFrom.isEmpty
                                                  ? ""
                                                  : NotificationsModel
                                                      .formatDate(
                                                          eventsController
                                                              .dateFrom),
                                              // TODO : refactor

                                              style: Styles.getMediumStyle(
                                                  color: Styles.lightBlack,
                                                  fontSize: fixDpiFont(12))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime _dateTime = DateTime.now();

                                      await showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (_) {
                                            final size =
                                                MediaQuery.of(context).size;

                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              height: size.height * 0.27,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                onDateTimeChanged:
                                                    (DateTime pickedDate) {
                                                  String formattedDate = DateFormat(
                                                          'yyyy-MM-dd HH:mm:ss')
                                                      .format(pickedDate);

                                                  con.setDateTo(formattedDate);
                                                },
                                                minimumDate: DateTime(
                                                  2023,
                                                  12,
                                                  20,
                                                ),
                                                maximumDate: DateTime(
                                                  2025,
                                                  12,
                                                  20,
                                                ),
                                                initialDateTime: _dateTime,
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Color(0xffEBEBEB),
                                          width: 1,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(AppStrings.to.tr,
                                            style: Styles.getMediumStyle(
                                                color: Styles.lightBlack,
                                                fontSize: fixDpiFont(12))),
                                        SizedBox(width: 4.w),
                                        Icon(Icons.calendar_month,
                                            color: Styles.lightBlack,
                                            size: fixDpiFont(12)),
                                        SizedBox(width: 4.w),
                                        Container(
                                          width: 130,
                                          child: Text(
                                              eventsController.dateTo.isEmpty
                                                  ? ""
                                                  : NotificationsModel
                                                      .formatDate(
                                                          eventsController
                                                              .dateTo),
                                              textAlign: TextAlign.start,
                                              style: Styles.getMediumStyle(
                                                  color: Styles.lightBlack,
                                                  fontSize: fixDpiFont(12))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    SizedBox(height: 16.h),
                    const TextFieldTitle(
                      title: "دولة الفعالية",
                      hasSubTitle: false,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                height: 500,
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
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
                                          "اختر دولة الفعالية",
                                          style: Styles.getMediumStyle(
                                              color: Color(0xff201D61),
                                              fontSize: 18),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 20.h),
                                          child: Icon(
                                            Icons.close,
                                            size: fixDpiFont(24),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Expanded(
                                      child: GetBuilder<EventsController>(
                                        builder: (evController) => Container(
                                          margin: EdgeInsets.only(
                                              top: 10.h, right: 8.w, left: 8.w),
                                          child: ListView.builder(
                                              itemCount: evController
                                                  .countryIds.length,
                                              shrinkWrap: true,
                                              itemBuilder: (_, i) {
                                                Country country =
                                                    evController.countryIds[i];
                                                return ListTile(
                                                  onTap: () {
                                                    evController
                                                        .onSelectcountry(i);
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16.w),
                                                  leading: Icon(
                                                    country.isSelected
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color: Styles.primaryColor,
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      Image.network(
                                                        country.flag,
                                                        width: 21,
                                                        height: 15,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(country.country),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            16.w, 16.h, 16.w, 20.h),
                                        child: CustomButton(
                                          type: ButtonType.primary,
                                          text: "تأكيد",
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              isDismissible: false);
                        },
                        child: GetBuilder<EventsController>(
                          builder: (evController) => DropDownListSelector(
                            dropDownList: [],
                            hint: evController.countryDisplayString,
                            blackHint: true,
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                          ),
                        )),
                    SizedBox(height: 16.h),
                    const TextFieldTitle(
                      title: "موضوع الفعالية",
                      hasSubTitle: false,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                height: 500,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
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
                                          "اختر موضوع الفعالية",
                                          style: Styles.getMediumStyle(
                                              color: Color(0xff201D61),
                                              fontSize: 18),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 20.h),
                                          child: Icon(
                                            Icons.close,
                                            size: fixDpiFont(24),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Expanded(
                                        child: GetBuilder<EventsController>(
                                      builder: (evController) => Container(
                                        height: 400,
                                        margin: EdgeInsets.only(
                                            top: 10.h, right: 8.w, left: 8.w),
                                        child: ListView.builder(
                                            itemCount: evController
                                                .jobCategoryIds.length,
                                            shrinkWrap: true,
                                            itemBuilder: (_, i) {
                                              JobCategory cat = evController
                                                  .jobCategoryIds[i];
                                              return ListTile(
                                                onTap: () {
                                                  evController
                                                      .onSelectjobCategory(i);
                                                },
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16.w),
                                                leading: Icon(
                                                  cat.isSelected
                                                      ? Icons.check_box
                                                      : Icons
                                                          .check_box_outline_blank,
                                                  color: Styles.primaryColor,
                                                ),
                                                title: Text(cat.name),
                                              );
                                            }),
                                      ),
                                    )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            16.w, 16.h, 16.w, 20.h),
                                        child: CustomButton(
                                          type: ButtonType.primary,
                                          text: "تأكيد",
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              isDismissible: false);
                        },
                        child: GetBuilder<EventsController>(
                          builder: (evController) => DropDownListSelector(
                            dropDownList: [],
                            hint: evController.jobCatDisplayString,
                            blackHint: true,
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                          ),
                        )),
                    SizedBox(height: 30.h),
                    CustomButton(
                      type: ButtonType.primary,
                      text: "إظهار النتائج",
                      onPressed: () async {
                        await controller.filterEvents();
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
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
    );
  }
}
