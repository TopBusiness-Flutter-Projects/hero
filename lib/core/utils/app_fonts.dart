import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_strings.dart';

TextStyle _getTextStyle(
    {required double fontSize,
      double? fontHeight,
      required FontWeight fontWeight,
      required Color color}) {
  return TextStyle(
      height: fontHeight,
      fontSize: fontSize,
      fontFamily: AppStrings.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// light style 300
TextStyle getLightStyle({Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black1,
      fontWeight: FontWeight.w300,
      fontSize: fontSize??16,
      fontHeight: fontHeight);
}

// regular style 400
TextStyle getRegularStyle(
    {Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black1,
      fontWeight: FontWeight.w400,
      fontSize: fontSize??16,
      fontHeight: fontHeight);
}

// regular style 600
TextStyle getMediumStyle(
    {Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black1,
      fontWeight: FontWeight.w600,
      fontSize: fontSize??16,
      fontHeight: fontHeight);
}


// bold style 700
TextStyle getBoldStyle({Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black1,
      fontWeight: FontWeight.w700,
      fontSize: fontSize??16,
      fontHeight: fontHeight);
}

// Extra Bold style 800
TextStyle getExtraStyle({Color? color, double? fontHeight, double? fontSize}) {
  return _getTextStyle(
      color: color ?? AppColors.black1,
      fontWeight: FontWeight.w800,
      fontSize:fontSize?? 16,
      fontHeight: fontHeight);
}
