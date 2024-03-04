import 'dart:developer';

import 'package:egyptians_abroad/app/core/custom_widgets/image_placeholder.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/widgets/grid_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/custom_widgets/custom_button.dart';
import '../../../../core/custom_widgets/grid_widget.dart';
import '../../../../core/custom_widgets/no_data_widget.dart';
import '../../../../core/custom_widgets/title_text.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/home_showcase_controller.dart';
import 'custoum_showcase_widget.dart';

class CategoriesListWidget extends StatelessWidget {
  CategoriesListWidget({
    super.key,
  });

  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
      // height: 524.h,
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
        // mainAxisSize: MainAxisSize.max,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleText(
            title: AppStrings.exploreServices.tr,
            fontSize: fixDpiFont(18),
          ),
          SizedBox(height: 7.h),
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

          // homeContoller.categoriesLoading
          //     ? Container(
          //         height: 200,
          //         child: const Center(
          //           child: CircularProgressIndicator(
          //             color: Styles.primaryColor,
          //           ),
          //         ),
          //       )
          //     :

          homeContoller.categoriesLoading
              ? GridPlaceholder()
              : homeContoller.displayedCategoriesList.isEmpty
                  ? Container(
                      height: 200,
                      padding: EdgeInsets.only(top: 20),
                      child: NoDataWidget(
                        message: AppStrings.noServices.tr,
                      ),
                    )
                  : Flexible(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 23.h),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 125.w,
                          childAspectRatio: 0.96,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: homeContoller.displayedCategoriesList.length,
                        itemBuilder: (ctx, i) {
                          return GridWidget(
                            i,
                            category: homeContoller.displayedCategoriesList[i],
                          );
                        },
                      ),
                    ),
          !homeContoller.categoriesLoading &&
                  homeContoller.displayedCategoriesList.isNotEmpty &&
                  homeContoller.showMore
              ? Showcase.withWidget(
                  height: 140,
                  width: 255.w,
                  key: homeContoller.three,
                  disposeOnTap: false,
                  targetShapeBorder: const CircleBorder(),
                  targetBorderRadius: const BorderRadius.all(
                    Radius.circular(150),
                  ),
                  // disableDefaultTargetGestures: true,
                  container: CustoumShowcase3Widget(),
                  onTargetClick: () => log('onTargerClick'),
                  onBarrierClick: () {
                    log('onBarrierClick');
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                    child: CustomButton(
                      type: ButtonType.secondary,
                      text: AppStrings.showMore.tr,
                      height: 50.h,
                      fontSize: 14,
                      // icon: Icons.arrow_forward,
                      iconSize: 13,
                      onPressed: () {
                        homeContoller.getMoreCategories();
                      },
                    ),
                  ),
                )
              : Container()
          // TODO: kindly check this view on EN language, may spacing make issue with allignment
        ],
      ),
    );
  }
}
