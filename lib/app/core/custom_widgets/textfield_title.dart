import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle(
      {super.key,
      required this.title,
      this.subTitle = "*",
      this.hasSubTitle = true,
      this.titleTextStyle,
      this.hasBottomMargin = true,
      this.hasHorizontalMargin = true,
      this.subTitlecolor = Colors.red,
      this.fontSize = 14});

  final String title;
  final String subTitle;
  final Color subTitlecolor;
  final bool hasSubTitle;
  final TextStyle? titleTextStyle;
  final bool hasBottomMargin;
  final bool hasHorizontalMargin;

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasBottomMargin
          ? hasHorizontalMargin
              ? EdgeInsets.only(bottom: 8.h, right: 6.w, left: 6.w)
              : EdgeInsets.only(bottom: 8.h)
          : hasHorizontalMargin
              ? EdgeInsets.only(bottom: 0, right: 6.w, left: 6.w)
              : const EdgeInsets.only(
                  bottom: 0,
                ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,
              style: titleTextStyle ??
                  Styles.getRegularStyle(
                      color: Styles.lightBlack, fontSize: fontSize)),
          hasSubTitle
              ? Text(subTitle,
                  style: TextStyle(
                    color: subTitlecolor,
                    fontSize: 16,
                  ))
              : Container()
        ],
      ),
    );
  }
}
