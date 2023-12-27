import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/title_text.dart';
import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/styles.dart';

class EventsAppbar extends StatelessWidget {
  const EventsAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, -0.02),
          end: Alignment(-1, 0.02),
          colors: [Color(0xFF726CFD), Color(0xFF2665F7)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // space
          SizedBox(height: fixDpiHeight(20)),
          // title
          TitleText(
            title: AppStrings.events.tr,
            color: Styles.white,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
