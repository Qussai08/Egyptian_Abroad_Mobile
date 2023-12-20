import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactElementWidget extends StatelessWidget {
  const ContactElementWidget({
    super.key,
    required this.imageAsset,
    this.imageScale,
    required this.text,
    required this.fontSize,
    this.onTap,
    this.textUnderline = false,
  });

  final String imageAsset;
  final double? imageScale;
  final String text;
  final double? fontSize;
  final void Function()? onTap;
  final bool textUnderline;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            imageAsset,
            scale: imageScale,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style:
                Styles.getRegularStyle(color: Styles.black, fontSize: fontSize!)
                    .copyWith(
                        decoration:
                            textUnderline ? TextDecoration.underline : null),
          )
        ],
      ),
    );
  }
}
