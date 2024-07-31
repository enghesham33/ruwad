import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'palette.dart';

class AppStyles {
  //--------------- application radius values---------------------/
  static double containerBigBorderRadius = 50;
  static double containerSmallBorderRadius = 10;
  static BorderRadius englishBorder = BorderRadius.only(
    topLeft: Radius.circular(containerSmallBorderRadius),
    bottomRight: Radius.circular(containerSmallBorderRadius),
    bottomLeft: Radius.circular(containerBigBorderRadius),
    topRight: Radius.circular(containerBigBorderRadius),
  );
  static BorderRadius arabicBorder = BorderRadius.only(
    topLeft: Radius.circular(containerBigBorderRadius),
    bottomRight: Radius.circular(containerBigBorderRadius),
    bottomLeft: Radius.circular(containerSmallBorderRadius),
    topRight: Radius.circular(containerSmallBorderRadius),
  );

  static double walletCardBorderRadius = 20;

  //--------------- application shadow boxes---------------------/
  static BoxShadow containerBoxShadow = BoxShadow(
    color: Palette.darkBorderColor.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: 5,
    offset: const Offset(1, 2),
  );

  //--------------- date format---------------------/
  static DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  //--------------- form field style ---------------------/
  static InputDecoration inputDecoration = const InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Palette.accentColor,
      ),
    ),
  );

  //--------------- application icons widths/heights ---------------------/
  static double dropDownMenuArrowHeight = 12.h;
  static double dropDownMenuArrowWidth = 12.h;

  //--------------- application widgets widths/heights---------------------/
  static double textFieldHeight = 50.h;
  static double textFieldTitleBottomMargin = 10.h;
}
