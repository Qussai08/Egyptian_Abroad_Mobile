import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/app_error_widget.dart';
import '../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/event_controller.dart';
import 'from_to_date_widget.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget({
    super.key,
    required this.controller,
  });

  final EventsController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Obx(() {
            return controller.eventsList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.eventsList.length,
                      itemBuilder: (context, index) {
                        final event = controller.eventsList[index];
                        print(controller.eventsList.length);
                        print(
                            "Event $index loaded with eventId ${event.eventId}");
                        return GestureDetector(
                          onTap: () {
                            print("event.eventId ${event.eventId}");
                            Get.toNamed(Routes.EVENT_DETAILS,
                                arguments: event.eventId);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 12.h, right: 16.w, left: 16.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Styles.blackShadow,
                                  blurRadius: 45,
                                  offset: Offset(10, 10),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              titleTextStyle: Styles.getBoldStyle(
                                  color: Styles.black2, fontSize: 16),
                              title: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        event.eventName ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 16,
                                      color: Color(0xff3F3D56),
                                      weight: 20,
                                    )
                                  ],
                                ),
                              ),
                              subtitle: FromToDateWidget(
                                fromDate: event.startDate!,
                                toDate: event.endDate!,
                                inEventsList: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Container(
                        child: Center(
                      child: Text(
                        AppStrings.noResult.tr,
                        style: Styles.getBoldStyle(
                          color: Styles.black,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  );
          }),

          // space
          SizedBox(height: fixDpiHeight(28)),
        ],
      ),
      // onLoading: const LoadingDialog(),
      // onError: (error) => AppErrorWidget(
      //       text: error ?? '',
      //       // text: ErrorHelper.getErrorMessage(int.parse(error ?? '')),
      //       onPress: () {
      //         controller.retry();
      //       },
      //     ),
      // onEmpty: Center(
      //   child: Text(
      //     AppStrings.noResult.tr,
      //     style: Styles.getBoldStyle(
      //       color: Styles.black,
      //       fontSize: 18,
      //     ),
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // )
    );
  }
}
