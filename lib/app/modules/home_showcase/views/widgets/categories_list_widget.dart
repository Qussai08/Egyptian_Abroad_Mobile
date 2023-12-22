import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/grid_widget.dart';
import '../../../../core/custom_widgets/no_data_widget.dart';
import '../../../../core/custom_widgets/title_text.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/home_showcase_controller.dart';

class CategoriesListWidget extends StatelessWidget {
  CategoriesListWidget({
    super.key,
  });

  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
      height: 524.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(28, 76, 159, 0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            title: AppStrings.exploreServices.tr,
            fontSize: fixDpiFont(18),
          ),
          TitleText(
            title: AppStrings.allServices.tr,
            fontSize: fixDpiFont(14),
            // TODO: need to handle TextStyle from Styles
            titleTextStyle: TextStyle(
                fontSize: fixDpiFont(14),
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(62, 60, 60, 0.71),
                fontFamily: 'baloo'),
          ),
          homeContoller.categoriesLoading ||
                  homeContoller.displayedCategoriesList.isEmpty
              ? const Spacer()
              : Container(),
          homeContoller.categoriesLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Styles.primaryColor,
                  ),
                )
              : homeContoller.displayedCategoriesList.isEmpty
                  ? NoDataWidget(
                      message: AppStrings.noServices.tr,
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: !homeContoller.showMore ? 425.h : 385.h,
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 15.h),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 125,
                              childAspectRatio: 0.96,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                homeContoller.displayedCategoriesList.length,
                            itemBuilder: (ctx, i) => GridWidget(
                              i,
                              category:
                                  homeContoller.displayedCategoriesList[i],
                            ),
                          ),
                        ),
                        homeContoller.showMore
                            ? Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                                child: CustomButton(
                                  type: ButtonType.secondary,
                                  text: AppStrings.showMore.tr,
                                  width: 110.w,
                                  height: 36.h,
                                  fontSize: 10,
                                  icon: Icons.arrow_forward,
                                  iconSize: 13,
                                  onPressed: () {
                                    homeContoller.getMoreCategories();
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ),
          // TODO: kindly check this view on EN language, may spacing make issue with allignment
          const Spacer(),
        ],
      ),
    );
  }
}
