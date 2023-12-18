import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/dpi_helper.dart';

class MainButton extends StatelessWidget {
  final Text text;
  final bool enable;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final Icon? icon;
  final VoidCallback? onPress;

  const MainButton(
      {super.key,
      required this.text,
      required this.enable,
      this.color,
      this.textColor,
      this.fontSize,
      this.icon,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(textColor ??
              Get.theme.colorScheme.background.withOpacity(enable ? 1 : 0.5)),
          backgroundColor: MaterialStateProperty.all<Color>(
              color ?? Get.theme.primaryColor.withOpacity(enable ? 1 : 0.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fixDpiHeight(30)),
          ))),
      onPressed: enable ? onPress : null,
      child: icon == null
          ? text
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [text, icon!],
            ),
    );
  }
}
