import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/dropdown_list_selector.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/theme/styles.dart';
import '../../../registration/data/models/country.dart';
import '../../controllers/event_controller.dart';

class CountryFilter extends StatelessWidget {
  const CountryFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsController>(
      builder: (evController) => GestureDetector(
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
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Icon(
                              Icons.close,
                              size: fixDpiFont(24),
                            ),
                          )
                        ]),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 10.h, right: 8.w, left: 8.w),
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
                                    country.isSelected
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                          child: CustomButton(
                            type: ButtonType.primary,
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
          child: DropDownListSelector(
            dropDownList: [],
            hint: evController.countryDisplayString,
            blackHint: true,
            hintFontSize: 14,
            hintFontWeight: FontWeight.w400,
          )),
    );
  }
}
