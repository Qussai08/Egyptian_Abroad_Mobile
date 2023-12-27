import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../../notifications/data/models/notifications_model/notifications_model.dart';
import '../../controllers/event_controller.dart';

class FilterDateWidget extends StatelessWidget {
  const FilterDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventsController con = Get.find();

    return GetBuilder<EventsController>(
        builder: (eventsController) => Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(37)),
                  border: Border.all(color: Color(0xffEBEBEB))),
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
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(pickedDate);

                                  con.setDateFrom(formattedDate);
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
                                  : NotificationsModel.formatDate(
                                      eventsController.dateFrom),
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
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
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
                            color: Styles.lightBlack, size: fixDpiFont(12)),
                        SizedBox(width: 4.w),
                        Container(
                          width: 130,
                          child: Text(
                              eventsController.dateTo.isEmpty
                                  ? ""
                                  : NotificationsModel.formatDate(
                                      eventsController.dateTo),
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
