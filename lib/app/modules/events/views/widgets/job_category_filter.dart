import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/custom_widgets/dropdown_list_selector.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../../registration/data/models/job_category.dart';
import '../../controllers/event_controller.dart';

class FilterWithJobCatWidget extends StatelessWidget {
  const FilterWithJobCatWidget({
    super.key,
    required this.controller,
    required this.jobCatSearchFocusNode,
  });

  final EventsController controller;
  final FocusNode jobCatSearchFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: GestureDetector(
          onTap: () {
            Get.bottomSheet(
                Container(
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Column(
                    children: [
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
                            "اختر موضوع الفعالية",
                            style: Styles.getMediumStyle(
                                color: Color(0xff201D61), fontSize: 18),
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
                      GetBuilder<EventsController>(
                        builder: (evController) => evController
                                .selectAllJobCategory
                            ? Container()
                            : Container(
                                margin: const EdgeInsets.only(
                                    top: 10, right: 12, left: 12),
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
                                    controller:
                                        controller.jobCategorySearchController,
                                    focusNode: jobCatSearchFocusNode,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Styles.primaryColor,
                                    ),
                                    inputData: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    onChangedFunc: (val) {
                                      jobCatSearchFocusNode.requestFocus();
                                      if (val.isEmpty) {
                                        controller.jobCategoryKeySearch = val;
                                        controller.filterJobCategoriesByName();
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    onFieldSubmitted: (val) {
                                      controller.jobCategoryKeySearch = val;
                                      controller.filterJobCategoriesByName();
                                    },
                                    hintTxt: AppStrings.search.tr,
                                    hintStyle: Styles.getRegularStyle(
                                        color: Styles.lightBlack)),
                              ),
                      ),
                      GetBuilder<EventsController>(
                        builder: (evController) => evController
                                .jobCategoryIds.isEmpty
                            ? Container(
                                // height: 200.h,
                                padding: EdgeInsets.only(top: 120.h),
                                child: Text(
                                  'لا توجد بيانات',
                                  style: Styles.getMediumStyle(
                                      color: Styles.lightBlack),
                                ),
                              )
                            : evController.jobCategoryKeySearch.isEmpty
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: 10.h, right: 8.w, left: 8.w),
                                    child: ListTile(
                                      onTap: () {
                                        evController.setSelectAllJobCategory(
                                            evController.selectAllJobCategory
                                                ? false
                                                : true);
                                        evController.onSelectjobCategory();
                                      },
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      leading: Icon(
                                        evController.selectAllJobCategory
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: Styles.primaryColor,
                                      ),
                                      title: Text("الكل"),
                                    ),
                                  )
                                : Container(),
                      ),
                      Expanded(
                          child: GetBuilder<EventsController>(
                        builder: (evController) => Container(
                          height: 400,
                          margin: EdgeInsets.only(right: 8.w, left: 8.w),
                          child: ListView.builder(
                              itemCount: evController.jobCategoryIds.length,
                              shrinkWrap: true,
                              itemBuilder: (_, i) {
                                JobCategory cat =
                                    evController.jobCategoryIds[i];
                                return ListTile(
                                  onTap: () {
                                    evController.onSelectjobCategory(index: i);
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  leading: Icon(
                                    evController.selectAllJobCategory
                                        ? Icons.check_box
                                        : cat.isSelected
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                    color: Styles.primaryColor,
                                  ),
                                  title: Text(cat.name),
                                );
                              }),
                        ),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                          child: CustomButton(
                            type: ButtonType.primary,
                            text: "تأكيد",
                            onPressed: () {
                              controller.onSelectjobCategory();
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
            builder: (evController) => DropDownListSelector(
              dropDownList: [],
              hint: evController.jobCatDisplayString,
              blackHint: true,
              hintFontSize: 14,
              hintFontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}
