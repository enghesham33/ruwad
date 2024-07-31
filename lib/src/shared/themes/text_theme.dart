import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'palette.dart';

class AppTextStyle {

  //====================Light Text Theme====================//
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 14.h,
      fontWeight: FontWeight.bold,
      color: Palette.darkBackgroundColor,
      height: 1.5.h,
    ),
    bodyMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 12.h,//14.0,
      fontWeight: FontWeight.bold,
      height: 1.5.h,
      color: Palette.darkBackgroundColor,
    ),
    bodySmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 10.h, //12.0,
      color: Palette.darkBackgroundColor,
      fontWeight: FontWeight.w600,
      height: 1.5.h,
    ),
    labelLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 20.0.h,
      fontWeight: FontWeight.bold,
      color: Palette.lightPrimaryColor,
    ),
    labelMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      fontWeight: FontWeight.w500,
      color: Palette.gray,
    ),
    labelSmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 16.0.h,
      fontWeight: FontWeight.bold,
      color: Palette.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
      height: 1.5.h,
    ),
    headlineMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 14.h,//16.0,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
    ),
    //headline2
    headlineSmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 12.h,//14.0,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
    ),
    displayLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      color: Palette.lightAccentColor,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 16.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.lightAccentColor,
    ),
    displaySmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 14.0.h,
      color: Palette.lightAccentColor,
    ),
  );

  //====================Dark Text Theme====================//
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 14.h,
      fontWeight: FontWeight.bold,
      color: Palette.white,
      height: 1.5.h,
    ),
    bodyMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 12.h,//14.0,
      fontWeight: FontWeight.bold,
      color: Palette.white,
      height: 1.5.h,
    ),
    bodySmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 10.h,
      color: Palette.white,
      fontWeight: FontWeight.w600,
      height: 1.5.h,
    ),
    labelLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.lightAccentColor,
    ),
    labelMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.gray,
    ),
    labelSmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 16.0.h,
      fontWeight: FontWeight.bold,
      color: Palette.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
      height: 1.5.h,
    ),
    headlineMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 14.h,//16.0,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
    ),
    //headline2
    headlineSmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 12.h,//14.0,
      fontWeight: FontWeight.w600,
      color: Palette.accentColor,
    ),
    displayLarge: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 18.0.h,
      color: Palette.lightAccentColor,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 16.0.h,
      fontWeight: FontWeight.w600,
      color: Palette.lightAccentColor,
    ),
    displaySmall: TextStyle(
      fontFamily: Constants.appFontFamily,
      fontSize: 16.0.h,
      color: Palette.lightAccentColor,
    ),
  );

  //====================Custom Light Text Styles====================//
  static TextStyle appBarLightTextStyle = lightTextTheme.displayLarge!.copyWith(
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle dialogTitleLightTextStyle = lightTextTheme.bodyLarge!;
  static TextStyle dialogContentLightTextStyle = lightTextTheme.bodyMedium!;
  static TextStyle toggleButtonsLightTextStyle = lightTextTheme.bodySmall!;

  static TextStyle elevatedButtonLightTextStyle = lightTextTheme.bodyMedium!;

  //====================Custom Dark Text Styles====================//
  static TextStyle appBarDarkTextStyle = darkTextTheme.displayLarge!.copyWith(
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle dialogTitleDarkTextStyle = darkTextTheme.bodyLarge!;
  static TextStyle dialogContentDarkTextStyle = darkTextTheme.bodyMedium!;
  static TextStyle toggleButtonsDarkTextStyle = darkTextTheme.bodySmall!;

  static TextStyle elevatedButtonDarkTextStyle = darkTextTheme.bodyMedium!;

}