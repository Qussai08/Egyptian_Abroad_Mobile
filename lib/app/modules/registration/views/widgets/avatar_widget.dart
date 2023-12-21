import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {super.key,
      required this.backgroundColor,
      required this.imageAsset,
      required this.isSelected,
      this.onTap});

  final Color backgroundColor;
  final String imageAsset;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(width: 5.0, color: Colors.blue),
                borderRadius: BorderRadius.circular(72.w),
              )
            : null,
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 72.w,
          child: Image.asset(imageAsset),
        ),
      ),
    );
  }
}
