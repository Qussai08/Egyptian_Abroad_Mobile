import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/events/controllers/event_details_controller.dart';
import 'package:egyptians_abroad/app/modules/events/views/widgets/from_to_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var event = controller.event;
    return Scaffold(
      appBar: CustomAppBar(
        title: TitleText(
          title: AppStrings.eventDetails.tr,
          color: Styles.darkGray,
          fontSize: 18,
        ),
      ),
      body: Obx(() {
        controller.isLoading.value
            ? context.loaderOverlay.show()
            : context.loaderOverlay.hide();
        return ListView(
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
                  TitleText(
                      title: controller.event().eventName ?? "",
                      fontSize: 16,
                      color: Styles.darkGray),
                  SizedBox(height: 12.h),
                  FromToDateWidget(
                      fromDate: event().startDate ?? "",
                      toDate: event().endDate ?? ""),
                  SizedBox(height: 12.h),
                  CustomButton(
                    type: ButtonType.primary,
                    iconIsAsset: true,
                    assetString: AppImages.linkIcon,
                    iconSize: fixDpiFont(14),
                    changeIconPosition: true,
                    text: event().isActive ?? false
                        ? AppStrings.meetingLink.tr
                        : AppStrings.recordingLink.tr,
                    width: 119.w,
                    height: 40.h,
                    fontSize: fixDpiFont(14),
                    fontWeight: FontWeight.w500,
                    onPressed: () => launchUrl(Uri.parse(event().link!)),
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
                      Expanded(
                        child: Text(
                          event().eventAddress ?? "",
                          style: Styles.getMediumStyle(color: Styles.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    event().eventDescription ?? "",
                    style: Styles.getMediumStyle(
                            color: Styles.black, fontSize: fixDpiFont(12))
                        .copyWith(height: 2.0),
                  ),
                  SizedBox(height: 99.h),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
