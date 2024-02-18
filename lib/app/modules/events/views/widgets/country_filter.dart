import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/custom_widgets/dropdown_list_selector.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../../registration/data/models/country.dart';
import '../../controllers/event_controller.dart';

class FilterWithCountryWidget extends StatelessWidget {
  const FilterWithCountryWidget({
    super.key,
    required this.controller,
    required this.countrySearchFocusNode,
  });

  final EventsController controller;
  final FocusNode countrySearchFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: GestureDetector(
          onTap: () {
            Get.bottomSheet(
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  height: 500,
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
                            "اختر دولة الفعالية",
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
                        builder: (evController) =>
                            evController.selectAllCountries
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
                                        controller: controller
                                            .countriesSearchController,
                                        focusNode: countrySearchFocusNode,
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Styles.primaryColor,
                                        ),
                                        inputData: TextInputType.text,
                                        textInputAction: TextInputAction.search,
                                        onChangedFunc: (val) {
                                          countrySearchFocusNode.requestFocus();
                                          if (val.isEmpty) {
                                            controller.countriesKeySearch = val;
                                            controller.filterCountriesByName();
                                            FocusScope.of(context).unfocus();
                                          }
                                        },
                                        onFieldSubmitted: (val) {
                                          controller.countriesKeySearch = val;
                                          controller.filterCountriesByName();
                                        },
                                        hintTxt: AppStrings.search.tr,
                                        hintStyle: Styles.getRegularStyle(
                                            color: Styles.lightBlack)),
                                  ),
                      ),
                      GetBuilder<EventsController>(
                        builder: (evController) =>
                            evController.countryIds.isEmpty
                                ? Container(
                                    // height: 200.h,
                                    padding: EdgeInsets.only(top: 120.h),
                                    child: Text(
                                      'لا توجد بيانات',
                                      style: Styles.getMediumStyle(
                                          color: Styles.lightBlack),
                                    ),
                                  )
                                : evController.countriesKeySearch.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 10.h, right: 8.w, left: 8.w),
                                        child: ListTile(
                                          onTap: () {
                                            evController.setSelectAllCountries(
                                                evController.selectAllCountries
                                                    ? false
                                                    : true);
                                            evController.onSelectcountry();
                                          },
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          leading: Icon(
                                            evController.selectAllCountries
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
                            margin: EdgeInsets.only(right: 8.w, left: 8.w),
                            child: ListView.builder(
                                itemCount: evController.countryIds.length,
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  Country country = evController.countryIds[i];
                                  return ListTile(
                                    onTap: () {
                                      evController.onSelectcountry(index: i);
                                    },
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    leading: Icon(
                                      // evController.selectAllCountries
                                      country.isSelected
                                          ? Icons.check_box
                                          : country.isSelected
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                      color: Styles.primaryColor,
                                    ),
                                    title: Row(
                                      children: [
                                        Image.network(
                                          country.flag,
                                          width: 21,
                                          height: 15,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(country.country),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                          child: CustomButton(
                            type: ButtonType.primary,
                            text: "تأكيد",
                            onPressed: () {
                              controller.onSelectcountry();
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
              hint: evController.countryDisplayString,
              blackHint: true,
              hintFontSize: 14,
              hintFontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}
