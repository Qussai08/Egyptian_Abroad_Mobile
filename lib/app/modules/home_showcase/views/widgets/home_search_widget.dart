import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/home_showcase_controller.dart';

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    super.key,
    required this.homeContoller,
  });

  final HomeShowcaseController homeContoller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: homeContoller.searchController,
      prefixIcon: const Icon(
        Icons.search,
        color: Styles.primaryColor,
      ),
      inputData: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChangedFunc: (val) {
        if (val.isEmpty) {
          homeContoller.keySearch = val;
          homeContoller.setKeySearch(homeContoller.keySearch, notifiy: true);
          FocusScope.of(context).unfocus();
        }
      },
      onFieldSubmitted: (val) {
        homeContoller.keySearch = val;
        homeContoller.setKeySearch(homeContoller.keySearch, notifiy: true);
      },
      hintTxt: AppStrings.searchForService.tr,
      // TODO: need to handle TextStyle from Styles
      hintStyle: TextStyle(
          fontSize: fixDpiFont(14),
          fontWeight: FontWeight.w400,
          fontFamily: 'baloo'),
    );
  }
}
