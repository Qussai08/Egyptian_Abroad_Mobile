import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/events/controllers/event_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/custom_widgets/app_error_widget.dart';
import '../../../core/custom_widgets/custom_textfield.dart';
import '../../../core/custom_widgets/loading_dialog.dart';
import '../../../core/helper/localization_helper.dart';
import '../../../core/theme/styles.dart';
import '../data/models/event_model.dart';
import 'widgets/events_appbar.dart';
import 'widgets/events_list_widget.dart';
import 'widgets/filter_widget.dart';
import 'widgets/from_to_date_widget.dart';
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
