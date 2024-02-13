import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'English Language support coming soon',
          style: Styles.getRegularStyle(
              color: Styles.grey_600, fontSize: fixDpiFont(13)),
        ),
        SizedBox(width: 8.w),
        Image.asset(
          AppImages.languageIcon,
          color: Styles.grey_600,
          scale: 2,
        ),
      ],
    );
  }
}
