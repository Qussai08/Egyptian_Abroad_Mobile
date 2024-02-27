import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? hasHorizontalMargin;
  final bool? enabled;
  final String? initialValue;
  final String? hintTxt;
  final TextInputType? inputData;
  final bool? isPassword;
  final String? Function(String?)? validationFunc;
  final Function(String)? onChangedFunc;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final bool? suffixIconIsImage;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? suffixIconImagePath;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final bool? prefixIconIsImage;
  final String? prefixIconImagePath;
  final String? labelText;
  final bool? expands;
  final bool? autofocus;
  final bool? enableBorder;
  final FocusNode? focusNode;
  final OutlineInputBorder? disabledBorder;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  final TextEditingController? controller;
  const CustomTextFormField(
      {super.key,
      this.hintTxt,
      this.inputData,
      this.disabledBorder,
      this.hasHorizontalMargin = false,
      this.autovalidateMode,
      this.isPassword = false,
      this.validationFunc,
      this.onFieldSubmitted,
      this.onSaved,
      this.onChangedFunc,
      this.enableBorder = true,
      this.initialValue,
      this.expands = false,
      this.suffixIcon,
      this.maxLength,
      this.enabled = true,
      this.maxLines,
      this.prefixIconIsImage = false,
      this.suffixIconIsImage = false,
      this.prefixIcon,
      this.autofocus = false,
      this.labelText,
      this.controller,
      this.suffixIconImagePath,
      this.prefixIconImagePath,
      this.prefix,
      this.hintStyle,
      this.textStyle,
      this.focusNode,
      this.textInputAction,
      this.fillColor = Colors.white,
      this.enabledBorderColor,
      this.inputFormatters});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          decoration: _focusNode.hasFocus
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: const Color(0xffEBEBEB)),
                  borderRadius: BorderRadius.circular(37.0),
                  // boxShadow: const [
                  //     BoxShadow(
                  //         color: Color.fromRGBO(0, 0, 0, 0.08),
                  //         blurRadius: 2.0,
                  //         spreadRadius: 0.4)
                  //   ]
                ),
          child: TextFormField(
            autovalidateMode:
                widget.autovalidateMode ?? AutovalidateMode.disabled,
            autofocus: widget.autofocus ?? false,
            textAlignVertical: TextAlignVertical.center,
            expands: widget.expands ?? false,
            controller: widget.controller,
            enabled: widget.enabled,
            maxLines: widget.maxLines ?? 1,
            focusNode: _focusNode,
            maxLength: widget.maxLength,
            initialValue: widget.initialValue,
            inputFormatters: widget.inputFormatters,
            textDirection: LocalizationHelper.isArabic()
                ? TextDirection.rtl
                : TextDirection.ltr,
            textAlign: LocalizationHelper.isArabic()
                ? TextAlign.right
                : TextAlign.left,
            style: widget.textStyle ??
                Styles.getRegularStyle(
                    color: Styles.black,
                    fontSize:
                        widget.isPassword! ? fixDpiFont(16) : fixDpiFont(14)),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              labelText: widget.labelText,
              fillColor: widget.fillColor,
              contentPadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: widget.isPassword! ? 0 : 10,
                  bottom: widget.isPassword! ? 0 : 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(37),
                  borderSide: BorderSide(
                    color: widget.enabledBorderColor != null
                        ? widget.enabledBorderColor!
                        : _focusNode.hasFocus
                            ? Styles.primaryColor
                            : Styles.grey_200,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(37),
                  borderSide: BorderSide(
                      color: _focusNode.hasFocus
                          ? Styles.primaryColor
                          : Styles.grey_200)), //
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(37),
                borderSide: const BorderSide(color: Styles.primaryColor),
              ),
              focusColor: Styles.primaryColor,
              suffixIcon: !widget.suffixIconIsImage!
                  ? widget.isPassword!
                      ? SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            icon: _obsecureText
                                ? Image.asset(AppImages.showPasswordIcon)
                                : Image.asset(AppImages.hidePasswordIcon),
                          ),
                        )
                      : widget.suffixIcon
                  : _focusNode.hasFocus
                      ? Image.asset(
                          widget.suffixIconImagePath!,
                          color: Styles.primaryColor,
                          height: 20,
                          width: 20,
                        )
                      : Image.asset(
                          widget.suffixIconImagePath!,
                          color: Colors.grey,
                          height: 25,
                          width: 25,
                        ),
              prefix: widget.prefix,
              prefixIcon: !widget.prefixIconIsImage!
                  ? widget.prefixIcon
                  : _focusNode.hasFocus
                      ? Image.asset(
                          widget.prefixIconImagePath!,
                          color: Styles.primaryColor,
                          height: 25,
                          width: 25,
                        )
                      : Image.asset(
                          widget.prefixIconImagePath!,
                          color: Styles.grey_400,
                          height: 25,
                          width: 25,
                        ),
              hintText: widget.hintTxt,
              errorStyle: Styles.getRegularStyle(
                  color: Styles.red, fontSize: fixDpiFont(11)),

              counterStyle: const TextStyle(
                height: 0,
                fontSize: 9,
              ),

              disabledBorder: widget.disabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(37.0),
                    borderSide: BorderSide(
                        color: _focusNode.hasFocus
                            ? Styles.primaryColor
                            : const Color(0xffEBEBEB)),
                  ),
              hintStyle: widget.hintStyle ??
                  Styles.getRegularStyle(
                      color: _focusNode.hasFocus
                          ? Styles.primaryColor
                          : Styles.grey_300),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            keyboardType: widget.inputData,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassword ?? false ? _obsecureText : false,
            validator: widget.validationFunc,
            onChanged: widget.onChangedFunc,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
          ));
    });
  }
}
