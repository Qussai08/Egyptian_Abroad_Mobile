import 'dart:developer';

import 'package:egyptians_abroad/app/core/custom_widgets/custom_card_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/controllers/home_showcase_controller.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/views/widgets/custoum_showcase_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class FavoritesList extends StatelessWidget {
  FavoritesList({super.key});
  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      height: 144,
      width: 255.w,
      key: homeContoller.two,
      container: CustoumShowcase2Widget(),
      onBarrierClick: () {
        log('onBarrierClick');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              AppStrings.favorites.tr,
              style: Styles.getBoldStyle(
                  color: Styles.black, fontSize: fixDpiFont(18)),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 120.h,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(right: 10.w, top: 5.h, bottom: 5.h),
                    child: GetBuilder<HomeShowcaseController>(
                        builder: (_controller) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _controller.favoritesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GridWidget(
                              index,
                              serviceItem: _controller.favoritesList[index],
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
