import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_images.dart';
import '../../../../core/theme/styles.dart';
import '../../data/models/notifications_model/notifications_model.dart';

class NotificationCardWidget extends StatelessWidget {
  NotificationCardWidget({
    super.key,
    required this.notification,
  });

  final NotificationsModel notification;
  final RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          isExpanded.value = !isExpanded.value;
        },
        child: Container(
            margin: EdgeInsets.only(bottom: fixDpiHeight(12)),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Styles.blackShadow,
                  blurRadius: 19,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: fixDpiWidth(16),
                vertical: fixDpiHeight(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // icon
                          SvgPicture.asset(
                            AppImages.calendarIcon,
                          ),

                          const SizedBox(width: 8),
                          Text(
                            '21 ديسمبر 2023 7:00 صباحا',
                            textAlign: TextAlign.right,
                            style: Styles.getMediumStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // arrow icon
                      Icon(
                        isExpanded()
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Styles.black3,
                        size: 24,
                      ),
                    ],
                  ),

                  // Title
                  Text(
                    notification.title ?? '',
                    maxLines: isExpanded() ? null : 1,
                    overflow: isExpanded() ? null : TextOverflow.ellipsis,
                    style: Styles.getBoldStyle(
                      color: Styles.black2,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: fixDpiHeight(8)),
                  Text(
                    notification.message ?? '',
                    maxLines: isExpanded() ? null : 2,
                    overflow: isExpanded() ? null : TextOverflow.ellipsis,
                    style: Styles.getMediumStyle(
                      color: Styles.black3,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
