import 'package:egyptians_abroad/app/core/custom_widgets/main_button.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogWidget extends StatelessWidget {
  final String subtitle;
  final bool? isSuccess;
  final String buttonText;
  final VoidCallback onPress;
  final double? textheight;
  final double? textsize;
  final double? titlesize;
  final Color? color;
  final String? title;
  final bool showButton;
  final String errorCode;

  const AlertDialogWidget(
      {Key? key,
      required this.subtitle,
      this.isSuccess = true,
      this.textheight,
      this.textsize,
      this.titlesize,
      required this.buttonText,
      required this.onPress,
      this.color,
      this.title,
      this.showButton = true,
      this.errorCode = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: fixDpiWidth(300),
        height: fixDpiHeight(280),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Styles.lightBlack,
              blurRadius: 45,
              offset: Offset(10, 10),
            ),
          ],
          color: Styles.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: fixDpiWidth(331),
              height: fixDpiHeight(68),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Styles.lightBlack,
                    blurRadius: 45,
                    offset: Offset(10, 10),
                  ),
                ],
                color: color ?? (isSuccess! ? Styles.green : Styles.red),
              ),
              child: Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Styles.backgroundColor,
                    fontSize: fixDpiFont(isSuccess! ? titlesize ?? 25.0 : 20.0),
                    fontWeight: FontWeight.w700,
                  ),
                  child: Text(
                    title ??
                        (isSuccess!
                            ? AppStrings.success.tr
                            : AppStrings.sorry.tr),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: fixDpiHeight(10)),
            SizedBox(
              width: fixDpiWidth(270),
              height: fixDpiHeight(textheight ?? 75),
              child: Column(
                children: [
                  DefaultTextStyle(
                      style: TextStyle(
                        color: Get.theme.textTheme.headline1!.color,
                        fontSize: fixDpiFont(textsize ?? 15),
                      ),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                      )),
                  Visibility(
                    visible: errorCode.isNotEmpty,
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: Get.theme.textTheme.headline1!.color,
                          fontSize: fixDpiFont(10),
                        ),
                        child: Text(
                          '\nCode: ($errorCode)',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: fixDpiHeight(10)),
            Visibility(
              visible: showButton,
              child: MainButton(
                enable: showButton,
                text: Text(buttonText),
                onPress: onPress,
                color: color ?? (isSuccess! ? Styles.successColor : Styles.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
