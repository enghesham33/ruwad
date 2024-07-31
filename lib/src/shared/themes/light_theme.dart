import 'package:flutter/material.dart';
import 'palette.dart';
import 'text_theme.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  primaryColor: Palette.primaryColor,
  focusColor: Palette.accentColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: AppTextStyle.lightTextTheme,
  primarySwatch: Palette.primarySwatchColor,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        brightness: Brightness.light,
        primary: Palette.primaryColor,
        secondary: Palette.accentColor,
      ),
  appBarTheme: AppBarTheme(
    backgroundColor: Palette.primaryColor,
    foregroundColor: Palette.lightAccentColor,
    titleTextStyle: AppTextStyle.appBarLightTextStyle,
  ),
  drawerTheme: DrawerThemeData(
    width: 100,
    backgroundColor: Palette.white.withOpacity(0.9),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) {
        return Palette.accentColor;
      },
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Palette.lightAccentColor,
    backgroundColor: Palette.lightPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80.0),
    ),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    selectedColor: Palette.white,
    //color: Palette.white,
    fillColor: Palette.lightPrimaryColor,
    splashColor: Palette.lightGray.withOpacity(0.1),
    textStyle: AppTextStyle.toggleButtonsLightTextStyle,
    borderWidth: 1.5,
    borderRadius: BorderRadius.circular(20),
    borderColor: Palette.lightGray.withOpacity(0.5),
    selectedBorderColor: Palette.lightGray,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: Palette.lightPrimaryColor,
    textColor: Palette.lightPrimaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Palette.lightGray,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Palette.lightPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(10.0), // Change the border radius as needed
    ),
    // titleTextStyle: AppTextStyle.dialogTitleLightTextStyle,
    // contentTextStyle: AppTextStyle.dialogContentLightTextStyle,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateColor.resolveWith(
        (states) => Palette.lightAccentColor,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateColor.resolveWith(
        (states) => Palette.lightPrimaryColor,
      ),
      foregroundColor: WidgetStateColor.resolveWith(
        (states) => Palette.black,
      ),
      textStyle: WidgetStateTextStyle.resolveWith(
          (states) => AppTextStyle.elevatedButtonLightTextStyle),
    ),
  ),
  // scaffoldBackgroundColor: Palette.darkBackgroundColor,
  // cardColor: Palette.darkBoxColor,
  // textSelectionTheme: const TextSelectionThemeData(cursorColor: Palette.darkPrimaryColor),
  // bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, shadowColor: Palette.geryColor),
  // dialogBackgroundColor: Colors.white,
);
