import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {Key? key,
      required this.title,
      this.titleTextStyle,
      this.fontSize = 24,
      this.color = Styles.black})
      : super(key: key);

  final String title;

  final TextStyle? titleTextStyle;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleTextStyle ??
          Styles.getBoldStyle(color: color, fontSize: fontSize),
    );
  }
}
