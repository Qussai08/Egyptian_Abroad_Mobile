import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_images.dart';
import '../../../../core/theme/styles.dart';
import '../../../../routes/app_pages.dart';
import '../../data/models/notifications_model/notifications_model.dart';

class NotificationEventCardWidget extends StatelessWidget {
  const NotificationEventCardWidget({
    super.key,
    required this.notification,
  });

  final NotificationsModel notification;

  @override
  Widget build(BuildContext context) {
    // print("notification.notificationId ${notification.notificationId}");
    return GestureDetector(
      onTap: () {
        print("notification.eventId ${notification.eventID}");
        Get.toNamed(Routes.EVENT_DETAILS,
            arguments: int.parse(notification.eventID ?? ""));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, right: 16.w, left: 16.w),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          titleTextStyle:
              Styles.getMediumStyle(color: Styles.black2, fontSize: 12),
          title: Container(
            margin: notification.notificationTypeId == 1
                ? const EdgeInsets.only(bottom: 12)
                : const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(notification.sentDate ?? ""),
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Color(0xff3F3D56),
                  weight: 20,
                )
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notification.notificationTypeId == 2)
                Row(
                  children: [
                    Image.asset("assets/icons/clock.png"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "تذكير" + "!",
                      maxLines: 1,
                      style: Styles.getBoldStyle(
                        color: Color(0xffFFA723),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              if (notification.notificationTypeId == 2)
                SizedBox(height: fixDpiHeight(8)),
              Text(
                "${notification.notificationTypeId == 1 ? 'تم اضافة فاعلية ' : ''}"
                "${notification.notificationTypeId == 2 ? notification.message : notification.title} ",
                maxLines: 2,
                textAlign: TextAlign.start,
                style: Styles.getBoldStyle(
                  fontSize: 14,
                  color: Styles.black3,
                ),
              ),
              if (notification.notificationTypeId == 1)
                Text(
                  "${notification.eventDescription}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Styles.getMediumStyle(
                    fontSize: 12,
                    color: Styles.black3,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
