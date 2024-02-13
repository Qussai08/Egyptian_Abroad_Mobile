import 'dart:developer';

import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/old_home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../home_showcase/controllers/home_showcase_controller.dart';
import '../../../home_showcase/views/widgets/custoum_showcase_widget.dart';

class FavoritesList extends StatelessWidget {
  FavoritesList({super.key});
  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      height: 144,
      width: 255.w,
      key: homeContoller.two,
      // targetShapeBorder: const CircleBorder(),
      // targetBorderRadius: const BorderRadius.all(
      //   Radius.circular(150),
      // ),
      // disableDefaultTargetGestures: true,
      container: CustoumShowcase2Widget(),
      onBarrierClick: () {
        log('onBarrierClick');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.favorites.tr,
              style: Styles.getBoldStyle(
                  color: Styles.black, fontSize: fixDpiFont(18)),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              height: 120.h,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.only(right: 10.w, top: 5.h, bottom: 5.h),
                      child: GetBuilder<HomeController>(builder: (controller) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.favoritesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GridWidget(
                                index,
                                serviceItem: controller.favoritesList[index],
                                inFavList: true,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
