import 'package:egyptians_abroad/app/core/custom_widgets/custom_card_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home/controllers/favorites_controller.dart';
import 'package:egyptians_abroad/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              CustomCardWidget(
                padding: EdgeInsets.only(right: 10.w, top: 5.h, bottom: 5.h),
                child: GetBuilder<HomeController>(builder: (_controller) {
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
            ],
          ),
        ),
      ],
    );
  }
}
