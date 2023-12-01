import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle(
      {Key? key,
      required this.title,
      this.subTitle = "*",
      this.hasSubTitle = true,
      this.titleTextStyle,
      this.hasBottomMargin = true,
      this.subTitlecolor = Colors.red,
      this.fontSize = 14})
      : super(key: key);

  final String title;
  final String subTitle;
  final Color subTitlecolor;
  final bool hasSubTitle;
  final TextStyle? titleTextStyle;
  final bool hasBottomMargin;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasBottomMargin
          ? EdgeInsets.only(bottom: 8.h, right: 6.w, left: 6.w)
          : EdgeInsets.only(bottom: 0, right: 6.w, left: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStyle ??
                TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'baloo'),
          ),
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
