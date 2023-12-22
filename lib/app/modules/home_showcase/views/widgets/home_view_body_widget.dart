import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/dpi_helper.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: fixDpiWidth(16)),
        child: homeContoller.userProfileLoading
            ? const HomeLoadingWidget()
            : Column(
                children: [
                  // Avatar and Name
                  AvatarAndNameWidget(),

                  // Search TextField
                  HomeSearchWidget(),

                  // Categories
                  CategoriesListWidget(),
                ],
              ),
      ),
    );
  }
}
