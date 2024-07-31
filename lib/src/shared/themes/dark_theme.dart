import 'package:flutter/material.dart';
import 'palette.dart';
import 'text_theme.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  primaryColor: Palette.primaryColor,
  focusColor: Palette.accentColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: AppTextStyle.darkTextTheme,
  primarySwatch: Palette.primarySwatchColor,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: Palette.primaryColor,
        secondary: Palette.accentColor,
      ),
  appBarTheme: AppBarTheme(
      backgroundColor: Palette.primaryColor,
      foregroundColor: Palette.lightAccentColor,
      titleTextStyle: AppTextStyle.appBarDarkTextStyle),
  drawerTheme: DrawerThemeData(
    width: 100,
    backgroundColor: Palette.darkContainerBackgroundColor.withOpacity(0.9),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) {
        return Palette.accentColor;
      },
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Palette.lightAccentColor,
    backgroundColor: Palette.lightPrimaryColor,
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    selectedColor: Palette.white,
    fillColor: Palette.lightPrimaryColor,
    splashColor: Palette.lightGray.withOpacity(0.1),
    textStyle: AppTextStyle.toggleButtonsDarkTextStyle,
    borderWidth: 1.5,
    borderRadius: BorderRadius.circular(20),
    borderColor: Palette.lightGray.withOpacity(0.5),
    selectedBorderColor: Palette.lightGray,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Palette.lightGray,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: Palette.lightPrimaryColor,
    textColor: Palette.lightPrimaryColor,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Palette.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(10.0), // Change the border radius as needed
    ),
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
        (states) => Palette.primaryColor,
      ),
      foregroundColor: WidgetStateColor.resolveWith(
        (states) => Palette.white,
      ),
      textStyle: WidgetStateTextStyle.resolveWith(
        (states) => AppTextStyle.elevatedButtonDarkTextStyle,
      ),
    ),
  ),
  // scaffoldBackgroundColor: Palette.darkBackgroundColor,
  // cardColor: Palette.darkBoxColor,
  // textSelectionTheme: const TextSelectionThemeData(cursorColor: Palette.darkPrimaryColor),
  // bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, shadowColor: Palette.grayColor),
  // dialogBackgroundColor: Colors.white,
);
