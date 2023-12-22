import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.step,
  });

  final String step;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.h,
      height: 38.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Styles.primaryColor, width: 3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "/3",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontFamily: 'baloo',
                fontSize: fixDpiFont(13),
                fontWeight: FontWeight.w700,
                color: Color(0xff91A8DD)),
          ),
          Text(
            step,
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontFamily: 'baloo',
                fontSize: fixDpiFont(17),
                fontWeight: FontWeight.w700,
                color: Styles.primaryColor),
          )
        ],
      ),
    );
  }
}
