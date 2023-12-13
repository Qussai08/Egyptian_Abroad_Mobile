import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.icon, required this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Styles.backgroundColor,
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        width: 320.w,
        height: 118.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              text,
              style: const TextStyle(color: Styles.grey_400),
            ),
          ],
        ),
      ),
    );
  }
}
