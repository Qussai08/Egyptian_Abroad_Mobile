import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dart:developer';

import '../../../../core/helper/dpi_helper.dart';
import '../../../home_showcase/views/widgets/favorites_list.dart';
import '../../controllers/home_showcase_controller.dart';
import 'avatar_and_name_widget.dart';
import 'categories_list_widget.dart';
import 'home_loading_widget.dart';
import 'home_search_widget.dart';

class HomeViewBodyWidget extends StatelessWidget {
  HomeViewBodyWidget({
    super.key,
  });

  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: homeContoller.scrollController,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: fixDpiWidth(16)),
        child: homeContoller.userProfileLoading
            ? const HomeLoadingWidget()
            : ShowCaseWidget(
                // add close button to the showcase view widget to close it manually
                onStart: (index, key) {
                  log('onStart: $index, $key');
                },
                onComplete: (index, key) {
                  log('onComplete: $index, $key');
                  if (index == 4) {
                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle.light.copyWith(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: Colors.white,
                      ),
                    );
                  }
                },

                blurValue: 3,
                builder: Builder(builder: (context) => HomeBodyWidget()),
                autoPlayDelay: const Duration(seconds: 3),
                disableBarrierInteraction: true,
                // enableShowcase: false,
              ),
      ),
    );
  }
}

class HomeBodyWidget extends StatelessWidget {
  HomeBodyWidget({
    super.key,
  });
  final homeContoller = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    homeContoller.startShowCase(context);
    return Flex(
      direction: Axis.vertical,
      children: [
        Column(
          children: [
            // Avatar and Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: fixDpiWidth(16)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AvatarAndNameWidget(),
                  // Search TextField
                  HomeSearchWidget(),

                  // Favorites
                  SizedBox(height: 19.h),
                  FavoritesList(),
                ],
              ),
            ),

            // Categories
            CategoriesListWidget(),
          ],
        ),
      ],
    );
  }
}
