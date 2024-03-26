import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/event_controller.dart';
import '../../data/models/event_model.dart';

class FilterWithDateWidget extends StatelessWidget {
  const FilterWithDateWidget({
    super.key,
    required this.con,
  });

  final EventsController con;

  @override
  Widget build(BuildContext context) {
    String formattedDateFrom = '';
    String formattedDateTo = '';
    return GetBuilder<EventsController>(
        builder: (eventsController) => Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(37)),
                  border: Border.all(color: const Color(0xffEBEBEB))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime _dateTime = DateTime.now();

                      await showCupertinoModalPopup<void>(
                          context: context,
                          builder: (_) {
                            final size = MediaQuery.of(context).size;

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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            if (formattedDateFrom.isEmpty) {
                                              formattedDateFrom = formattedDateTo
                                                      .isNotEmpty
                                                  ? formattedDateTo
                                                  : intl.DateFormat(
                                                          'yyyy-MM-dd HH:mm:ss')
                                                      .format(_dateTime);
                                            }
                                            con.setDateFrom(formattedDateFrom);
                                            Get.back();
                                            formattedDateTo = formattedDateFrom;
                                            // formattedDateFrom = '';
                                          },
                                          child: Text(
                                            'تأكيد',
                                            style: Styles.getMediumStyle(
                                                color: Styles.primaryColor),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                            // formattedDateFrom = '';
                                          },
                                          child: Text(
                                            'إلغاء',
                                            style: Styles.getMediumStyle(
                                                color: Styles.primaryColor),
                                          )),
                                    ],
                                  ),
                                  Expanded(
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (DateTime pickedDate) {
                                        formattedDateFrom = intl.DateFormat(
                                                'yyyy-MM-dd HH:mm:ss')
                                            .format(pickedDate);

                                        // con.setDateFrom(formattedDate);
                                      },
                                      maximumDate: con.dateTo.isNotEmpty
                                          ? DateTime.parse(con.dateTo)
                                          : null,
                                      initialDateTime: con.dateFrom.isNotEmpty
                                          ? DateTime.parse(con.dateFrom)
                                          : con.dateTo.isNotEmpty
                                              ? DateTime.parse(con.dateTo)
                                              : _dateTime,
                                    ),
                                  ),
                                ],
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
                                  : Event.dateFormatter(
                                      eventsController.dateFrom,
                                      dateOnly: true),
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
                            final size = MediaQuery.of(context).size;

                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              height: size.height * 0.27,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            if (formattedDateTo.isEmpty) {
                                              formattedDateTo = formattedDateFrom
                                                      .isNotEmpty
                                                  ? formattedDateFrom
                                                  : intl.DateFormat(
                                                          'yyyy-MM-dd HH:mm:ss')
                                                      .format(_dateTime);
                                            }
                                            con.setDateTo(formattedDateTo);
                                            Get.back();
                                            formattedDateFrom = formattedDateTo;
                                          },
                                          child: Text(
                                            'تأكيد',
                                            style: Styles.getMediumStyle(
                                                color: Styles.primaryColor),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                            // formattedDateTo = '';
                                          },
                                          child: Text(
                                            'إلغاء',
                                            style: Styles.getMediumStyle(
                                                color: Styles.primaryColor),
                                          )),
                                    ],
                                  ),
                                  Expanded(
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (DateTime pickedDate) {
                                        formattedDateTo = intl.DateFormat(
                                                'yyyy-MM-dd HH:mm:ss')
                                            .format(pickedDate);

                                        // con.setDateTo(formattedDate);
                                      },
                                      minimumDate: con.dateFrom.isNotEmpty
                                          ? DateTime.parse(con.dateFrom)
                                          : null,
                                      initialDateTime: con.dateTo.isNotEmpty
                                          ? DateTime.parse(con.dateTo)
                                          : con.dateFrom.isNotEmpty
                                              ? DateTime.parse(con.dateFrom)
                                              : _dateTime,
                                    ),
                                  ),
                                ],
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
                            color: Styles.lightBlack, size: fixDpiFont(12)),
                        SizedBox(width: 4.w),
                        Container(
                          width: 130,
                          child: Text(
                              eventsController.dateTo.isEmpty
                                  ? ""
                                  : Event.dateFormatter(eventsController.dateTo,
                                      dateOnly: true),
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
            ));
  }
}
