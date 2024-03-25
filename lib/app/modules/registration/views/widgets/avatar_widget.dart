import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {super.key,
      required this.backgroundColor,
      required this.imageAsset,
      required this.isSelected,
      this.radius,
      this.width,
      this.onTap});

  final Color backgroundColor;
  final String imageAsset;
  final bool isSelected;
  final double? radius;
  final double? width;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(width: 5.w, color: Colors.blue),
                borderRadius: BorderRadius.circular(
                    radius != null ? radius! + 10.0 : 82.w),
              )
            : null,
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: radius ?? 72.w,
          child: SvgPicture.asset(
            imageAsset,
            width: width,
            // scale: imageScale,
          ),
        ),
      ),
    );
  }
}
