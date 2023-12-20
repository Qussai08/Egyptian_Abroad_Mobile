import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:egyptians_abroad/app/modules/more/views/widgets/column_element_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.imageAsset,
    this.imageScale,
    this.horizontalPadding,
    this.height,
    this.onTap,
  });

  final String text;
  final String imageAsset;
  final double? imageScale;
  final double? horizontalPadding;
  final double? height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 26.w),
      height: height ?? 71.h,
      child: ContactElementWidget(
          onTap: onTap,
          imageAsset: imageAsset,
          imageScale: imageScale ?? 1,
          text: text,
          fontSize: fixDpiFont(16)),
    );
  }
}
