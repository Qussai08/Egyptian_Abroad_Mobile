import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.imageAsset, required this.text});
  final String imageAsset;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageAsset),
        SizedBox(height: 16.h),
        Text(
          text,
          style: Styles.getBoldStyle(
            color: Colors.black,
            fontSize: fixDpiFont(24),
          ),
        ),
      ],
    );
  }
}
