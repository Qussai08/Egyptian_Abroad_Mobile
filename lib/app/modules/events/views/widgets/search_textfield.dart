import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/event_controller.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget(
      {super.key, required this.controller, required this.searchFocusNode});

  final EventsController controller;
  final FocusNode searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Styles.blackShadow,
              blurRadius: 45,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: CustomTextFormField(
            controller: controller.searchController,
            focusNode: searchFocusNode,
            prefixIcon: const Icon(
              Icons.search,
              color: Styles.primaryColor,
            ),
            inputData: TextInputType.text,
            textInputAction: TextInputAction.search,
            onChangedFunc: (val) {
              searchFocusNode.requestFocus();
              if (val.isEmpty) {
                controller.keySearch = val;
                controller.clear();
                controller.loadEvents();
                FocusScope.of(context).unfocus();
              }
            },
            onFieldSubmitted: (val) {
              controller.keySearch = val;
              controller.clear();
              controller.filterEvents();
            },
            hintTxt: AppStrings.search.tr,
            hintStyle: Styles.getRegularStyle(color: Styles.lightBlack)),
      ),
    );
  }
}
