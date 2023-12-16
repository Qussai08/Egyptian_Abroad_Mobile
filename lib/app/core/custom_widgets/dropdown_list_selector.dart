import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
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
  final bool reverseArrowPosition;
  final double hintFontSize;
  final FontWeight hintFontWeight;

  const DropDownListSelector(
      {super.key,
      required this.dropDownList,
      this.hint,
      this.value,
      this.onChangeFunc,
      this.decoration,
      this.elementHasDefaultMargin = true,
      this.blackHint = false,
      this.reverseArrowPosition = false,
      this.hintFontSize = 18,
      this.hintFontWeight = FontWeight.w700});
  @override
  _DropDownListSelectorState createState() => _DropDownListSelectorState();
}

class _DropDownListSelectorState extends State<DropDownListSelector> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalizationHelper.isArabic() && !widget.reverseArrowPosition
              ? TextDirection.rtl
              : TextDirection.ltr,
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
                border:
                    Border.all(color: const Color.fromARGB(255, 237, 239, 240)),
              ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(10),
              isExpanded: widget.reverseArrowPosition ? false : true,
              hint: Text(
                widget.hint ?? "",
                style: TextStyle(
                    color: widget.blackHint
                        ? Colors.black
                        : const Color(0xffC8C8C8),
                    fontSize: fixDpiFont(widget.hintFontSize),
                    fontWeight: widget.hintFontWeight,
                    fontFamily: "baloo"),
              ),
              focusColor: Styles.primaryColor,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Styles.dropdownArrowGrey,
              ),
              style: Styles.getRegularStyle(color: Styles.black),
              items: widget.dropDownList,
              onChanged: widget.onChangeFunc,
              value: widget.value,
              alignment: widget.reverseArrowPosition
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
            ),
          )),
    );
  }
}
