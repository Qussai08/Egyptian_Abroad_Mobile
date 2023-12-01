import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  ghost,
  danger,
  dangerPrimary,
  transparent,
  disabled
}

extension ButtonTypeExtension on ButtonType {
  Color get textColor {
    switch (this) {
      case ButtonType.primary:
        return Styles.white;
      case ButtonType.secondary:
        return Styles.black;
      case ButtonType.ghost:
        return Styles.primaryColor;
      case ButtonType.danger:
        return Styles.onDangerColor;
      case ButtonType.dangerPrimary:
        return Styles.onPrimaryColor;
      case ButtonType.transparent:
        return Styles.grey_400;
      case ButtonType.disabled:
        return Styles.onDisabledColor;
      default:
        return Styles.primaryColor;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ButtonType.primary:
        return Styles.primaryColor;
      case ButtonType.secondary:
        return Styles.secondaryButtonColor;
      case ButtonType.ghost:
        return Styles.white;
      case ButtonType.danger:
        return Styles.dangerColor;
      case ButtonType.dangerPrimary:
        return Styles.dangerPrimaryColor;
      case ButtonType.transparent:
        return Colors.transparent;
      case ButtonType.disabled:
        return Styles.disabledColor;
      default:
        return Styles.primaryColor;
    }
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.text,
      this.widget,
      this.width = double.infinity,
      this.height = 50,
      this.type = ButtonType.primary,
      this.disabledText,
      this.onPressed,
      this.onLongPressed,
      this.fontSize = 16,
      this.icon,
      this.isLoading = false,
      this.iconSize = 20,
      this.fontWeight = FontWeight.w700})
      : assert(
            (text == null && widget != null) ||
                (text != null && widget == null),
            "text and widget cannot be defined simultaneously"),
        assert(text != null || widget != null, "Must define text or widget");
  final String? text;
  final Widget? widget;
  final double width;
  final double height;
  final ButtonType type;
  final String? disabledText;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final double fontSize;
  final IconData? icon;
  final bool isLoading;
  final FontWeight fontWeight;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isLoading ? Colors.transparent : type.backgroundColor,
        borderRadius: BorderRadius.circular(100),
        gradient: type == ButtonType.primary
            ? const LinearGradient(
                colors: [Color(0xff2665F7), Color(0xff4D91C6)])
            : null,
      ),
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
          style: TextButton.styleFrom(
            // backgroundColor:
            //     isLoading ? Colors.transparent : type.backgroundColor,
            shape: type == ButtonType.ghost
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: const BorderSide(color: Styles.primaryColor))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
          ),
          onPressed: type == ButtonType.disabled ? null : onPressed,
          onLongPress: onLongPressed,
          child: isLoading
              ? SizedBox(
                  height: height - 10,
                  width: height - 10,
                  child: const CircularProgressIndicator(
                    backgroundColor: Styles.primaryColor,
                  ),
                )
              : widget ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type == ButtonType.disabled
                            ? disabledText ?? text!
                            : text!,
                        style: TextStyle(
                            fontSize: fontSize,
                            color: type.textColor,
                            fontWeight: fontWeight,
                            fontFamily: 'baloo'),
                      ),
                      if (icon != null)
                        const SizedBox(
                          width: 5,
                        ),
                      if (icon != null)
                        Icon(
                          icon,
                          color: type.textColor,
                          size: iconSize,
                        ),
                    ],
                  )),
    );
  }
}
