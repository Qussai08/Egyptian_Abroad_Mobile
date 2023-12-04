import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class DropDownListSelector extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> dropDownList;
  final String? hint;
  final dynamic value;
  final void Function(dynamic)? onChangeFunc;
  final bool? elementHasDefaultMargin;
  final BoxDecoration? decoration;
  final bool blackHint;

  const DropDownListSelector(
      {super.key,
      required this.dropDownList,
      this.hint,
      this.value,
      this.onChangeFunc,
      this.decoration,
      this.elementHasDefaultMargin = true,
      this.blackHint = false});
  @override
  _DropDownListSelectorState createState() => _DropDownListSelectorState();
}

class _DropDownListSelectorState extends State<DropDownListSelector> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalizationHelper.isArabic() ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
          height: 48,
          padding: const EdgeInsets.all(8.0),

          // margin: widget.elementHasDefaultMargin ??
          //      EdgeInsets.symmetric(
          //         horizontal: MediaQuery.of(context).size.width * 0.07)
          //     : EdgeInsets.symmetric(horizontal: 0),
          decoration: widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(37.0),
                border: Border.all(color: Styles.textFieldBorderColor),
              ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              isExpanded: true,
              hint: Text(
                widget.hint ?? "",
                style: TextStyle(
                    color: widget.blackHint ? Colors.black : Color(0xffC8C8C8),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "dubai"),
              ),
              focusColor: Styles.primaryColor,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Styles.dropdownArrowGrey,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              items: widget.dropDownList,
              onChanged: widget.onChangeFunc,
              value: widget.value,
            ),
          )),
    );
  }
}
