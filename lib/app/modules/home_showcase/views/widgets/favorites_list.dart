import 'dart:developer';

import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/controllers/home_showcase_controller.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/widgets/custoum_showcase_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:showcaseview/showcaseview.dart';

class FavoritesList extends StatelessWidget {
  FavoritesList({super.key});
  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      height: 169.h,
      width: 331.w,
      targetPadding: EdgeInsets.all(8.0),
      key: homeContoller.two,
      disposeOnTap: false,
      container: CustoumShowcase2Widget(),
      onBarrierClick: () {
        log('onBarrierClick');
      },
      onTargetClick: () => log('onTargetClick'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              AppStrings.favorites.tr,
              style: Styles.getBoldStyle(
                  color: Styles.black, fontSize: fixDpiFont(18)),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 130.h,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GetBuilder<HomeShowcaseController>(
                        builder: (controller) {
                      // controller.favoritesIsLoading
                      //     ? context.loaderOverlay.show()
                      //     : context.loaderOverlay.hide();
                      return controller.favoriteCategories.isEmpty ||
                              controller.favoritesList.isEmpty
                          ? Container()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.favoritesList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GridWidget(
                                    index,
                                    category:
                                        controller.favoriteCategories[index],
                                    serviceItem:
                                        controller.favoritesList[index],
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
    );
  }
}
