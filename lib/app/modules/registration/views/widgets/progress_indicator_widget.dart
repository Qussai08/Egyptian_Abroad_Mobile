import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget(
      {super.key, required this.step, this.total = "3"});

  final String step;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.h,
      height: 38.h,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: 0.33333333 * int.parse(step),
            valueColor:
                const AlwaysStoppedAnimation<Color>(Styles.primaryColor),
            backgroundColor: const Color(0xffE7F2F4),
            strokeWidth: 4,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "/$total",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontFamily: 'baloo',
                        fontSize: fixDpiFont(13),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff91A8DD)),
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
            ),
          ),
        ],
      ),
    );
  }
}
