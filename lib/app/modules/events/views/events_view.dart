import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/modules/events/controllers/event_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'widgets/events_appbar.dart';
import 'widgets/events_list_widget.dart';
import 'widgets/filter_widget.dart';
import 'widgets/search_textfield.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode _searchFocusNode = FocusNode();
    FocusNode _countrySearchFocusNode = FocusNode();

    FocusNode _jobCatSearchFocusNode = FocusNode();

    final con = Get.put(EventsController());
    // final RegistrationController regController = Get.find();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, fixDpiHeight(110)),
          child: EventsAppbar(),
        ),
        body: Obx(() {
          controller.isLoading()
              ? context.loaderOverlay.show()
              : context.loaderOverlay.hide();
          return Column(
            children: [
              Container(
                height: 65,
                margin: EdgeInsets.only(
                    right: 16.w, left: 8.w, top: 12.h, bottom: 12.h),
                child: Row(
                  children: [
                    SearchTextFieldWidget(
                      controller: controller,
                      searchFocusNode: _searchFocusNode,
                    ),
                    FilterWidget(
                      con: con,
                      jobCatSearchFocusNode: _jobCatSearchFocusNode,
                      countrySearchFocusNode: _countrySearchFocusNode,
                    ),
                  ],
                ),
              ),
              EventsListWidget(
                controller: controller,
              )
            ],
          );
        }));
  }
}
