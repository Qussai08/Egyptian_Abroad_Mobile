import 'package:flutter/material.dart';

import '../helper/dpi_helper.dart';
import '../theme/styles.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: fixDpiWidth(130),
          height: fixDpiHeight(130),
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
          // child: Center(child: Image.asset(AppImages.loading)),
          // circle loading
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.primaryColor),
            ),
          )),
    );
  }
}
