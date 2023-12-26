import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FromToDateWidget extends StatelessWidget {
  const FromToDateWidget({
    super.key,
    required this.fromDate,
    required this.toDate,
  });
  final String fromDate;
  final String toDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.from.tr,
          style: Styles.getMediumStyle(
              color: Styles.lightBlack, fontSize: fixDpiFont(12)),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.calendar_month,
          color: Styles.lightBlack,
          size: fixDpiFont(12),
        ),
        SizedBox(width: 4.w),
        Text(fromDate,
            style: Styles.getMediumStyle(
                color: Styles.lightBlack, fontSize: fixDpiFont(12))),
        SizedBox(width: 12.w),
        Text(AppStrings.to.tr,
            style: Styles.getMediumStyle(
                color: Styles.lightBlack, fontSize: fixDpiFont(12))),
        SizedBox(width: 4.w),
        Icon(Icons.calendar_month,
            color: Styles.lightBlack, size: fixDpiFont(12)),
        SizedBox(width: 4.w),
        Text(toDate,
            style: Styles.getMediumStyle(
                color: Styles.lightBlack, fontSize: fixDpiFont(12))),
      ],
    );
  }
}
