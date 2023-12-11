import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../helper/localization_helper.dart';
import '../theme/styles.dart';
import 'change_language_sheet_widget.dart';

class ChangeLangButtonWidget extends StatelessWidget {
  const ChangeLangButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openChangeLanguageSheet();
      },
      child: Container(
        width: LocalizationHelper.isArabic() ? 113.w : 133.w,
        height: 37.h,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF438AE7), Color(0xFF5E57FD)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
            SizedBox(
              child: Text(
                  LocalizationHelper.isArabic() ? 'English' : 'اللغة العربية',
                  textAlign: TextAlign.right,
                  style: Styles.getSemiBoldStyle(
                    color: Styles.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openChangeLanguageSheet() async {
    await showBarModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) => ChangeLanguageWidget(
        languageId:
            LocalizationHelper.isArabic() ? Language.arabic : Language.english,
        onChanged: (val) {
          if (val != null) LocalizationHelper().changeLocale(val);
          Get.back();
        },
      ),
    );
  }
}
