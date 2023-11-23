import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {Key? key, required this.title, this.titleTextStyle, this.fontSize = 24})
      : super(key: key);

  final String title;

  final TextStyle? titleTextStyle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleTextStyle ??
          TextStyle(
              color: Styles.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w700),
    );
  }
}
