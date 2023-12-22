import 'package:flutter/material.dart';

class Styles {
  static final ThemeData myTheme = ThemeData(
      // primarySwatch: MaterialColor() const Color(0xff438AE7),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff438AE7),
      ),
      //   fontFamily: 'baloo',
      scaffoldBackgroundColor: Colors.white);

  final inputDecoration = InputDecoration(
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(37), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(37),
          borderSide: const BorderSide(color: Styles.primaryColor)),
      counterText: "",
      hintText: "");

// brand
  static const primaryColor = Color(0xff438AE7);
  static const primaryVariantColor = Colors.black;

// main
  static const backgroundColor = Color(0xffFBFBFB);
  static const surfaceColor = Color.fromRGBO(255, 255, 255, 1);

// semantic
  static const successColor = Color.fromRGBO(1, 198, 161, 0.1);
  static const dangerColor = Color.fromRGBO(255, 228, 228, 1);
  static const dangerPrimaryColor = Color.fromRGBO(255, 60, 30, 1);

  static const disabledColor = Color.fromRGBO(237, 241, 247, 1);

// text
  static const onPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
  static const onSecondaryColor = Color.fromRGBO(34, 43, 69, 1);

  static const onBackgroundColor = Color.fromRGBO(150, 150, 150, 1);
  static const onSurfaceColor = Color.fromRGBO(64, 64, 64, 1);

  static const onSuccessColor = Color.fromRGBO(8, 190, 156, 1);
  static const onDangerColor = Color.fromRGBO(255, 106, 106, 1);
  static const onDisabledColor = Color.fromRGBO(108, 111, 127, 1);

// textField
  static const textFieldColor = Color(0xffF4F4F6);
  static const textFieldBorderColor = Color(0xffDCDEE0);

// yellow warning
  static const lightYellow = Color.fromRGBO(254, 249, 240, 1);
  static const yellow = Color.fromRGBO(226, 174, 10, 1);

  // green disclamer
  static const lightGreen = Color.fromARGB(255, 229, 248, 234);
  static const green = Color(0xff469F7A);

  // black
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const lightBlack = Color.fromRGBO(0, 0, 0, 0.5);
  static const mediumBlack = Color(0xff121212);
  static const blackShadow = Color(0x261C4C9F);
  static const black2 = Color(0xFF3E3C3C);
  static const black3 = Color(0xFF4F4F4F);

  // static const blueBlack = Color(0xFF201D61);

  static const blueBlack = Color(0xff1C304C);

  // white
  static const white = Color.fromRGBO(255, 255, 255, 1);

  // grey
  static const grey_600 = Color.fromRGBO(117, 117, 117, 1);
  static const grey_400 = Color(0xFF909090);
  static const grey_300 = Color.fromRGBO(163, 163, 163, 1);
  static const grey_200 = Color.fromRGBO(221, 221, 221, 1);
  static const grey_100 = Color.fromRGBO(245, 245, 245, 1);
  static const dividerColor = Color(0xFFEBEBEB);
  static const greyText = Color(0xff848484);
  static const dropdownArrowGrey = Color(0xff6A6A6F);
  static const ghostGrey = Color(0xff717171);
  static const matchBackGroundGrey = Color(0xffFFFEF8);
  static const matchBorderGrey = Color(0xffEAEAEA);
  static const secondaryButtonColor = Color(0xffF8F8F8);
  static const transGrey = Color.fromRGBO(62, 60, 60, 0.71);
  static const blueGrey = Color(0xff3F3D56);

  static const red = Color(0xffD71A21);
  static const heavyRed = Color(0xffBA1212);
  static const disabledGreyColor = Color(0xffC7C7C7);

  // Radio styles
  static const radioBorder = Color.fromRGBO(145, 168, 221, 1);

  // Text Styles
  static TextStyle _getTextStyle(
      double fontSize, FontWeight fontWeight, color) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'baloo');
  }

  static TextStyle getRegularStyle(
      {double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getMediumStyle(
      {double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getLightStyle(
      {double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getBoldStyle(
      {double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }

  static TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s30 = 30.0;
}
