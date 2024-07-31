import 'package:flutter/material.dart';

class Palette {

  static const int primaryColorHexCode = 0xff507772;
  static const MaterialColor primarySwatchColor =  MaterialColor(primaryColorHexCode, appRGBColor);

  //========== app colors ==========//
  static const primaryColor = Color(0xff507772);
  static const accentColor = Color(0xffaa8b56);
  static const lightPrimaryColor = Color(0xff749F9B);
  static const lightAccentColor = Color(0xfff0ebce);
  static const darkOlive = Color(0xff556B2F);
  static const lightOlive = Color.fromARGB(161, 235, 255, 146);

  //========== light mode ==========//
  static const lightGray = Color(0xFFE1E1E1);
  static const containerBorderColor = Color(0xFFE3E3E3);
  static const scaffoldBackgroundColor = Color(0xFFFAFAFA);

  //========== dark mode ==========//
  static const darkBackgroundColor = Color(0xFF1B2026);
  static const darkBorderColor = Color(0xFF353A44);
  static const darkBoxColor = Color(0xFF282C35);
  static const darkContainerBackgroundColor = Color(0xFF363A44);
  static const gray = Color(0xFF808080);

  //========== other colors ==========//
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const orange = Color(0xFFD38D56); //Warning
  static const red = Color(0xFFA85244); //Error
  static const green = Color(0xFF4C7F4D); //Success
  static const blue = Color(0xFF406E80); //Info

  // static const Color darkGreen = Color(0xff507772);
  // static const Color lightGreen = Color(0xff749F9B);
  // static const Color grey = Color(0xff393E46);
  // static const Color lightGray = Colors.grey;
  //snack bar colors
  // static const Color snackBarWarning = Colors.orange;
  // static const Color snackBarError = Colors.red;
  // static const Color snackBarSuccess = Colors.green;
  // // plan status colors
  // static const Color planNotStarted = Color(0xffEDDEAA);
  // static const Color planOngoing = Color(0xff818f6b);
  // static const Color planEnded= Color(0xffAFAAAD);
  // // task types colors
  // static const Color taskRepeat = Color(0xffffa600);
  // static const Color taskPrayer = Color(0xff003f5c);
  // static const Color taskTest = Color(0xff58508d);
  // // mandatory / optional task colors
  // static const Color taskMandatory = Color(0xff484944);
  // static const Color taskOptional = Color(0xff1f2e60);

  static const Map<int, Color> appRGBColor = {
    50: Color.fromRGBO(5, 87, 132, .1),
    100: Color.fromRGBO(5, 87, 132, .2),
    200: Color.fromRGBO(5, 87, 132, .3),
    300: Color.fromRGBO(5, 87, 132, .4),
    400: Color.fromRGBO(5, 87, 132, .5),
    500: Color.fromRGBO(5, 87, 132, .6),
    600: Color.fromRGBO(5, 87, 132, .7),
    700: Color.fromRGBO(5, 87, 132, .8),
    800: Color.fromRGBO(5, 87, 132, .9),
    900: Color.fromRGBO(5, 87, 132, 1),
  };
}