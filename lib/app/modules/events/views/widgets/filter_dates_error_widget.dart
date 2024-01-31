import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/helper/localization_helper.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/event_controller.dart';

class FilterDatesErrorWidget extends StatelessWidget {
  const FilterDatesErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsController>(
      builder: (eventsController) => eventsController.showDatesError
          ? Container(
              margin: EdgeInsets.only(top: 4, right: 8.w, left: 8.w),
              child: Row(
                children: [
                  Text(
                    'يجب اختيار تاريخ بدء ونهاية الفاعلية',
                    textAlign: LocalizationHelper.isArabic()
                        ? TextAlign.right
                        : TextAlign.left,
                    maxLines: 1,
                    textDirection: LocalizationHelper.isArabic()
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.getRegularStyle(
                        color: Colors.red, fontSize: fixDpiFont(12)),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
