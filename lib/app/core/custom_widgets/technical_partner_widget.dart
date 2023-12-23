import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicalPartnerWidget extends StatelessWidget {
  const TechnicalPartnerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.technicalPartner.tr,
          style: Styles.getRegularStyle(
                  fontSize: fixDpiFont(12), color: Styles.grey_600)
              .copyWith(fontFamily: 'helvetica'),
        ),
        Image.asset(AppImages.technicalPartner),
      ],
    );
  }
}
