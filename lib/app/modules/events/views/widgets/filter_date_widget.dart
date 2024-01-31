import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../../notifications/data/models/notifications_model/notifications_model.dart';
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
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime pickedDate) {
                                  String formattedDate =
                                      intl.DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(pickedDate);

                                  con.setDateFrom(formattedDate);
                                },
                                maximumDate: con.dateTo.isNotEmpty
                                    ? DateTime.parse(con.dateTo)
                                    : null,
                                initialDateTime: con.dateTo.isNotEmpty
                                    ? DateTime.parse(con.dateTo)
                                    : _dateTime,
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
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime pickedDate) {
                                  String formattedDate =
                                      intl.DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(pickedDate);

                                  con.setDateTo(formattedDate);
                                },
                                minimumDate: con.dateFrom.isNotEmpty
                                    ? DateTime.parse(con.dateFrom)
                                    : null,
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
