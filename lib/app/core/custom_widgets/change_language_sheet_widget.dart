import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../helper/localization_helper.dart';
import '../theme/styles.dart';
import 'custom_button.dart';

class ChangeLanguageWidget extends StatefulWidget {
  final Function(Language?)? onChanged;
  Language language;
  ChangeLanguageWidget({
    super.key,
    required this.onChanged,
    required this.language,
  });

  @override
  _ChangeLanguageWidgetState createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 340.h,
      color: Colors.white,
      child:
          // change language widget radio buttons
          Column(
        children: <Widget>[
          //  Header
          Container(
            width: double.infinity,
            height: 68.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border.all(
                color: const Color(0xFFE7F2F3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // icon language
                const Icon(Icons.language, color: Styles.primaryColor),
                const SizedBox(width: 11),
                Text(
                  AppStrings.selectLanguage.tr,
                  textAlign: TextAlign.center,
                  style: Styles.getMediumStyle(
                    color: Styles.blueBlack,
                    fontSize: FontSize.s24,
                  ),
                ),
              ],
            ),
          ),

          // space 28
          SizedBox(height: 28.h),

          InkWell(
            onTap: () {
              setState(() {
                widget.language = Language.arabic;
              });
            },
            child: _buildLangRow(
                langID: Language.arabic, langName: 'اللغة العربية'),
          ),

          // space 13
          SizedBox(height: 13.h),

          InkWell(
            onTap: () {
              setState(() {
                widget.language = Language.english;
              });
            },
            child: _buildLangRow(langID: Language.english, langName: 'English'),
          ),

          const Spacer(),
          CustomButton(
            text: AppStrings.select.tr,
            type: ButtonType.primary,
            height: 50,
            onPressed: () => widget.onChanged!(widget.language),
          ),
          SizedBox(height: 29.h),
        ],
      ),
    );
  }

  Container _buildLangRow({
    required Language langID,
    required String langName,
  }) {
    return Container(
      height: 50.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: widget.language == langID
            ? Styles.secondaryButtonColor
            : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 11),
          Radio(
            value: langID,
            groupValue: widget.language,
            onChanged: (Language? value) {
              setState(() {
                widget.language = value!;
              });
            },
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Styles.primaryColor;
                }
                return Styles.radioBorder; // Use the component's default.
              },
            ),
          ),
          Text(
            langName,
            textAlign: TextAlign.center,
            style: Styles.getBoldStyle(
              color: Styles.blueBlack,
              fontSize: FontSize.s17,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
