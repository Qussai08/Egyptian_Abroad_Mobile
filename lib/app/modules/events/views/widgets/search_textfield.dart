import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_textfield.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/event_controller.dart';

class searchTextFieldWidget extends StatelessWidget {
  const searchTextFieldWidget({
    super.key,
    required this.controller,
  });

  final EventsController controller;

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
            prefixIcon: const Icon(
              Icons.search,
              color: Styles.primaryColor,
            ),
            inputData: TextInputType.text,
            textInputAction: TextInputAction.search,
            onChangedFunc: (val) {
              if (val.isEmpty) {
                controller.keySearch = val;
                controller.filterEvents();
                FocusScope.of(context).unfocus();
              }
            },
            onFieldSubmitted: (val) {
              controller.keySearch = val;
              controller.filterEvents();
            },
            hintTxt: AppStrings.search.tr,
            hintStyle: Styles.getRegularStyle(color: Styles.lightBlack)),
      ),
    );
  }
}
