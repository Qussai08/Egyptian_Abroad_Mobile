import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    this.onTap,
  });

  final bool isFavorite;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.w),
        child: Container(
          width: 28.w,
          height: 28.h,
          color: Styles.white,
          child: isFavorite
              ? Icon(
                  Icons.favorite,
                  color: Styles.red,
                  size: 16.w,
                )
              : Icon(
                  Icons.favorite,
                  color: Styles.grey_400,
                  size: 16.w,
                ),
        ),
      ),
    );
  }
}
