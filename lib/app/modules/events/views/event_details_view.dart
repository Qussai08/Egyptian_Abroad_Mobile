import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/events/views/widgets/from_to_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: TitleText(
          title: AppStrings.eventDetails.tr,
          color: Styles.darkGray,
          fontSize: 18,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 35.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            decoration: BoxDecoration(
              color: Styles.white,
              borderRadius: BorderRadius.circular(12.w),
              boxShadow: const [
                BoxShadow(
                  color: Styles.blackShadow,
                  blurRadius: 19,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17.5.h),
                const TitleText(
                    title: 'مؤتمر إتحاد الجاليات المصرية بالخارج',
                    fontSize: 16,
                    color: Styles.darkGray),
                SizedBox(height: 12.h),
                const FromToDateWidget(
                    fromDate: '21 ديسمبر 2023  7:00 ص',
                    toDate: '21 ديسمبر 2023  7:00 ص'),
                SizedBox(height: 12.h),
                CustomButton(
                  type: ButtonType.primary,
                  iconIsAsset: true,
                  assetString: AppImages.linkIcon,
                  iconSize: fixDpiFont(14),
                  changeIconPosition: true,
                  text: AppStrings.recordingLink.tr,
                  width: 119.w,
                  height: 40.h,
                  fontSize: fixDpiFont(14),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12.w,
                      backgroundColor: Styles.lightBlue,
                      child: Image.asset(AppImages.locationOutlinedIcon),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'العنوان الخاص بالفعالية باللغة بالعربية',
                      style: Styles.getMediumStyle(color: Styles.black),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم  هذا نص توضيحى هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم  هذا نص توضيحىهذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم  هذا نص توضيحى هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض التصميم هذا نص توضيحى يستخدم لاغراض',
                  style: Styles.getMediumStyle(
                          color: Styles.black, fontSize: fixDpiFont(12))
                      .copyWith(height: 2.0),
                ),
                SizedBox(height: 99.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
