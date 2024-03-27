import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
      required this.imageAsset,
      required this.text,
      this.width,
      this.isSvg = false});
  final String imageAsset;
  final String text;
  final double? width;
  final bool isSvg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSvg
            ? SvgPicture.asset(imageAsset)
            : Image.asset(
                imageAsset,
                width: width,
                // scale: imageScale,
              ),
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
