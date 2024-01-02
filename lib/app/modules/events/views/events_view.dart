import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/events/controllers/event_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/custom_widgets/app_error_widget.dart';
import '../../../core/custom_widgets/custom_textfield.dart';
import '../../../core/custom_widgets/loading_dialog.dart';
import '../../../core/custom_widgets/title_text.dart';
import '../../../core/theme/styles.dart';
import '../../notifications/data/models/notifications_model/notifications_model.dart';
import 'widgets/events_appbar.dart';
import 'widgets/from_to_date_widget.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode _searchFocusNode = FocusNode();

    final con = Get.put(EventsController());
    // final RegistrationController regController = Get.find();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, fixDpiHeight(110)),
          child: EventsAppbar(),
        ),
        body: Column(
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(
                  right: 16.w, left: 8.w, top: 12.h, bottom: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.blackShadow,
                            blurRadius: 45,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: CustomTextFormField(
                          controller: controller.searchController,
                          focusNode: _searchFocusNode,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Styles.primaryColor,
                          ),
                          inputData: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onChangedFunc: (val) {
                            _searchFocusNode.requestFocus();
                            if (val.isEmpty) {
                              controller.keySearch = val;
                              controller.filterEvents();
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onFieldSubmitted: (val) {
                            controller.keySearch = val;
                            controller.filterEvents();
                          },
                          hintTxt: AppStrings.search.tr,
                          hintStyle:
                              Styles.getRegularStyle(color: Styles.lightBlack)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: const BoxDecoration(
                                  color: Color(0xffE7F2F4),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              height: 68.h,
                              child: Row(children: [
                                Container(
                                  width: fixDpiFont(24),
                                ),
                                Spacer(),
                                Text(
                                  "بحث باستخدام",
                                  style: Styles.getMediumStyle(
                                      color: Color(0xff201D61), fontSize: 24),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Icon(
                                      Icons.close,
                                      size: fixDpiFont(24),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                children: [
                                  TextFieldTitle(
                                    title: "تاريخ بدء الفعالية",
                                    hasSubTitle: false,
                                  ),
                                  GetBuilder<EventsController>(
                                      builder: (eventsController) => Container(
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(37)),
                                                border: Border.all(
                                                    color: Color(0xffEBEBEB))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    DateTime _dateTime =
                                                        DateTime.now();

                                                    await showCupertinoModalPopup<
                                                            void>(
                                                        context: context,
                                                        builder: (_) {
                                                          final size =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size;

                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                              ),
                                                            ),
                                                            height:
                                                                size.height *
                                                                    0.27,
                                                            width:
                                                                fixDpiScreenWidth(),
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .date,
                                                              onDateTimeChanged:
                                                                  (DateTime
                                                                      pickedDate) {
                                                                String
                                                                    formattedDate =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd HH:mm:ss')
                                                                        .format(
                                                                            pickedDate);

                                                                con.setDateFrom(
                                                                    formattedDate);
                                                              },
                                                              minimumDate:
                                                                  DateTime(
                                                                2023,
                                                                12,
                                                                20,
                                                              ),
                                                              maximumDate:
                                                                  DateTime(
                                                                2025,
                                                                12,
                                                                20,
                                                              ),
                                                              initialDateTime:
                                                                  _dateTime,
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppStrings.from.tr,
                                                        style: Styles
                                                            .getMediumStyle(
                                                                color: Styles
                                                                    .lightBlack,
                                                                fontSize:
                                                                    fixDpiFont(
                                                                        12)),
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Icon(
                                                        Icons.calendar_month,
                                                        color:
                                                            Styles.lightBlack,
                                                        size: fixDpiFont(12),
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Container(
                                                        width: 130,
                                                        child: Text(
                                                            eventsController
                                                                    .dateFrom
                                                                    .isEmpty
                                                                ? ""
                                                                : NotificationsModel
                                                                    .formatDate(
                                                                        eventsController
                                                                            .dateFrom),
                                                            // TODO : refactor

                                                            style: Styles.getMediumStyle(
                                                                color: Styles
                                                                    .lightBlack,
                                                                fontSize:
                                                                    fixDpiFont(
                                                                        12))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    DateTime _dateTime =
                                                        DateTime.now();

                                                    await showCupertinoModalPopup<
                                                            void>(
                                                        context: context,
                                                        builder: (_) {
                                                          final size =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size;

                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                              ),
                                                            ),
                                                            height:
                                                                size.height *
                                                                    0.27,
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .date,
                                                              onDateTimeChanged:
                                                                  (DateTime
                                                                      pickedDate) {
                                                                String
                                                                    formattedDate =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd HH:mm:ss')
                                                                        .format(
                                                                            pickedDate);

                                                                con.setDateTo(
                                                                    formattedDate);
                                                              },
                                                              minimumDate:
                                                                  DateTime(
                                                                2023,
                                                                12,
                                                                20,
                                                              ),
                                                              maximumDate:
                                                                  DateTime(
                                                                2025,
                                                                12,
                                                                20,
                                                              ),
                                                              initialDateTime:
                                                                  _dateTime,
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        color:
                                                            Color(0xffEBEBEB),
                                                        width: 1,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Text(AppStrings.to.tr,
                                                          style: Styles
                                                              .getMediumStyle(
                                                                  color: Styles
                                                                      .lightBlack,
                                                                  fontSize:
                                                                      fixDpiFont(
                                                                          12))),
                                                      SizedBox(width: 4.w),
                                                      Icon(Icons.calendar_month,
                                                          color:
                                                              Styles.lightBlack,
                                                          size: fixDpiFont(12)),
                                                      SizedBox(width: 4.w),
                                                      Container(
                                                        width: 130,
                                                        child: Text(
                                                            eventsController
                                                                    .dateTo
                                                                    .isEmpty
                                                                ? ""
                                                                : NotificationsModel
                                                                    .formatDate(
                                                                        eventsController
                                                                            .dateTo),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: Styles.getMediumStyle(
                                                                color: Styles
                                                                    .lightBlack,
                                                                fontSize:
                                                                    fixDpiFont(
                                                                        12))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                  SizedBox(height: 12.h),
                                  const TextFieldTitle(
                                    title: "دولة الفعالية",
                                    hasSubTitle: false,
                                  ),
                                  Container(
                                    height: 50.h,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12))),
                                                height: 500,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xffE7F2F4),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12))),
                                                      height: 68.h,
                                                      child: Row(children: [
                                                        Container(
                                                          width: fixDpiFont(24),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          "اختر دولة الفعالية",
                                                          style: Styles
                                                              .getMediumStyle(
                                                                  color: Color(
                                                                      0xff201D61),
                                                                  fontSize: 18),
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        20.h),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: fixDpiFont(
                                                                  24),
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                    Expanded(
                                                      child: GetBuilder<
                                                          EventsController>(
                                                        builder:
                                                            (evController) =>
                                                                Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10.h,
                                                                  right: 8.w,
                                                                  left: 8.w),
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      evController
                                                                          .countryIds
                                                                          .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (_, i) {
                                                                    Country
                                                                        country =
                                                                        evController
                                                                            .countryIds[i];
                                                                    return ListTile(
                                                                      onTap:
                                                                          () {
                                                                        evController
                                                                            .onSelectcountry(i);
                                                                      },
                                                                      contentPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 16.w),
                                                                      leading:
                                                                          Icon(
                                                                        country.isSelected
                                                                            ? Icons.check_box
                                                                            : Icons.check_box_outline_blank,
                                                                        color: Styles
                                                                            .primaryColor,
                                                                      ),
                                                                      title:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            country.flag,
                                                                            width:
                                                                                21,
                                                                            height:
                                                                                15,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(country
                                                                              .country),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.w,
                                                                16.h,
                                                                16.w,
                                                                20.h),
                                                        child: CustomButton(
                                                          type: ButtonType
                                                              .primary,
                                                          text: "تأكيد",
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              isDismissible: false);
                                        },
                                        child: GetBuilder<EventsController>(
                                          builder: (evController) =>
                                              DropDownListSelector(
                                            dropDownList: [],
                                            hint: evController
                                                .countryDisplayString,
                                            blackHint: true,
                                            hintFontSize: 14,
                                            hintFontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  SizedBox(height: 12.h),
                                  const TextFieldTitle(
                                    title: "موضوع الفعالية",
                                    hasSubTitle: false,
                                  ),
                                  Container(
                                    height: 50.h,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                              Container(
                                                height: 500,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12))),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xffE7F2F4),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12))),
                                                      height: 68.h,
                                                      child: Row(children: [
                                                        Container(
                                                          width: fixDpiFont(24),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          "اختر موضوع الفعالية",
                                                          style: Styles
                                                              .getMediumStyle(
                                                                  color: Color(
                                                                      0xff201D61),
                                                                  fontSize: 18),
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        20.h),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: fixDpiFont(
                                                                  24),
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                    Expanded(
                                                        child: GetBuilder<
                                                            EventsController>(
                                                      builder: (evController) =>
                                                          Container(
                                                        height: 400,
                                                        margin: EdgeInsets.only(
                                                            top: 10.h,
                                                            right: 8.w,
                                                            left: 8.w),
                                                        child: ListView.builder(
                                                            itemCount: evController
                                                                .jobCategoryIds
                                                                .length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (_, i) {
                                                              JobCategory cat =
                                                                  evController
                                                                      .jobCategoryIds[i];
                                                              return ListTile(
                                                                onTap: () {
                                                                  evController
                                                                      .onSelectjobCategory(
                                                                          i);
                                                                },
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            16.w),
                                                                leading: Icon(
                                                                  cat.isSelected
                                                                      ? Icons
                                                                          .check_box
                                                                      : Icons
                                                                          .check_box_outline_blank,
                                                                  color: Styles
                                                                      .primaryColor,
                                                                ),
                                                                title: Text(
                                                                    cat.name),
                                                              );
                                                            }),
                                                      ),
                                                    )),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.w,
                                                                16.h,
                                                                16.w,
                                                                20.h),
                                                        child: CustomButton(
                                                          type: ButtonType
                                                              .primary,
                                                          text: "تأكيد",
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              isDismissible: false);
                                        },
                                        child: GetBuilder<EventsController>(
                                          builder: (evController) =>
                                              DropDownListSelector(
                                            dropDownList: [],
                                            hint: evController
                                                .jobCatDisplayString,
                                            blackHint: true,
                                            hintFontSize: 14,
                                            hintFontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomButton(
                                    type: ButtonType.primary,
                                    text: "إظهار النتائج",
                                    onPressed: () async {
                                      await controller.filterEvents();
                                      Get.back();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.blackShadow,
                            blurRadius: 45,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppImages.filterIcon,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: controller.obx(
                  (state) => ListView(
                        children: [
                          Obx(() {
                            return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.eventsList.length,
                              itemBuilder: (context, index) {
                                final event = controller.eventsList[index];

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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                      titleTextStyle: Styles.getBoldStyle(
                                          color: Styles.black2, fontSize: 16),
                                      title: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              event.eventName ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                          toDate: event.endDate!),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),

                          // space
                          SizedBox(height: fixDpiHeight(28)),
                        ],
                      ),
                  onLoading: const LoadingDialog(),
                  onError: (error) => AppErrorWidget(
                        text: error ?? '',
                        // text: ErrorHelper.getErrorMessage(int.parse(error ?? '')),
                        onPress: () {
                          controller.retry();
                        },
                      ),
                  onEmpty: Center(
                    child: Text(
                      AppStrings.noResult.tr,
                      style: Styles.getBoldStyle(
                        color: Styles.black,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            )
          ],
        ));
  }
}
