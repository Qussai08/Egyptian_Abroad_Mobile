import 'package:flutter/material.dart';

import '../../../../core/helper/dpi_helper.dart';

import '../../controllers/home_showcase_controller.dart';
import 'avatar_and_name_widget.dart';
import 'categories_list_widget.dart';
import 'home_loading_widget.dart';
import 'home_search_widget.dart';

class HomeViewBodyWidget extends StatelessWidget {
  const HomeViewBodyWidget({
    super.key,
    required this.homeContoller,
  });

  final HomeShowcaseController homeContoller;

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
                  AvatarAndNameWidget(homeContoller: homeContoller),

                  // Search TextField
                  HomeSearchWidget(homeContoller: homeContoller),

                  // Categories
                  CategoriesListWidget(homeContoller: homeContoller)
                ],
              ),
      ),
    );
  }
}
