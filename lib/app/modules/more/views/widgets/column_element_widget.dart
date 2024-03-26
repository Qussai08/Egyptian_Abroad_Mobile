import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactElementWidget extends StatelessWidget {
  const ContactElementWidget({
    super.key,
    required this.imageAsset,
    this.imageScale,
    required this.text,
    required this.fontSize,
    this.onTap,
    this.textUnderline = false,
    this.isRichText = false,
    this.richText,
    this.isSvg = false,
  });

  final String imageAsset;
  final double? imageScale;
  final String text;
  final double? fontSize;
  final void Function()? onTap;
  final bool textUnderline;
  final bool isRichText;
  final Widget? richText;
  final bool isSvg;
  @override
  Widget build(BuildContext context) {
    return isRichText
        ? Row(
            children: [
              isSvg
                  ? SvgPicture.asset(
                      imageAsset,
                    )
                  : Image.asset(
                      imageAsset,
                      scale: imageScale,
                    ),
              Expanded(child: richText!),
            ],
          )
        : InkWell(
            onTap: onTap,
            child: Row(
              children: [
                isSvg
                    ? SvgPicture.asset(
                        imageAsset,
                      )
                    : Image.asset(
                        imageAsset,
                        scale: imageScale,
                      ),
                SizedBox(width: 12.w),
                Text(
                  text,
                  style: Styles.getRegularStyle(
                          color: Styles.black, fontSize: fontSize!)
                      .copyWith(
                          decoration:
                              textUnderline ? TextDecoration.underline : null),
                )
              ],
            ),
          );
  }
}
