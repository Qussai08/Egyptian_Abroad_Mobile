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
      child: Container(
        width: 32.w,
        height: 32.w,
        color: Colors.transparent,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
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
