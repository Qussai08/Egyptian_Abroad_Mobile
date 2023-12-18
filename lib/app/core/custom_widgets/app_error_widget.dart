import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/dpi_helper.dart';
import '../language/app_string.dart';
import '../theme/styles.dart';
import 'main_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String text;
  final Function onPress;
  const AppErrorWidget({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: fixDpiWidth(250),
        height: fixDpiHeight(200),
        padding: EdgeInsetsDirectional.all(fixDpiWidth(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Styles.blackShadow,
              blurRadius: 45,
              offset: Offset(10, 10),
            ),
          ],
          // color: Get.theme.backgroundColor,
        ),
        child: Column(
          children: [
            Text(
              text,
              style: Styles.getBoldStyle(color: Styles.primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: fixDpiHeight(10)),
            SizedBox(
              width: double.infinity,
              height: fixDpiHeight(50),
              child: MainButton(
                  enable: true,
                  text: Text(
                    AppStrings.tryAgain.tr,
                    style: Styles.getBoldStyle(color: Styles.white),
                  ),
                  onPress: () => onPress()),
            )
          ],
        ),
      ),
    );
  }
}
