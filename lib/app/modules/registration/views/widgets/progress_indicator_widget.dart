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
      width: 25.w,
      height: 25.w,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      // color: Colors.red,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                value: total == "3"
                    ? 0.33333333 * int.parse(step)
                    : 0.25 * int.parse(step),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Styles.primaryColor),
                backgroundColor: const Color(0xffE7F2F4),
                strokeWidth: 4,
              ),
            ),
          ),
          Center(
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
        ],
      ),
    );
  }
}
