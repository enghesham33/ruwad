import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';

class SettingsLocalDataSource{
  final String _languageBoxName = "language";
  final String _languageKey = "languageKey";

  final String _themeBoxName = "theme";
  final String _themeKey = "themeKey";

  final String _dateCultureBoxName = "dateCulture";
  final String _dateCultureKey = "dateCultureKey";

  Future<String> getLanguage() async{
    var box = await Hive.openBox(_languageBoxName);
    String languageCode = Constants.ar;

    if(box.isEmpty){
      languageCode = Platform.localeName.split("_").first; //en_GB
      box.put(_languageKey, languageCode);
    } else {
      languageCode = box.get(_languageKey);
    }

    print("[SettingsLocalDataSource] App language: $languageCode");
    return languageCode;
  }

  Future<void> switchLanguage() async{
    var box = await Hive.openBox(_languageBoxName);
    box.put(_languageKey, box.get(_languageKey) == Constants.ar ? Constants.en : Constants.ar);

    print("[SettingsLocalDataSource] App language switched to: ${box.get(_languageKey)}");
  }

  Future<ThemeMode> getThemeMode() async{
    var box = await Hive.openBox(_themeBoxName);
    ThemeMode themeMode = ThemeMode.light;

    if(box.isEmpty){
      box.put(_themeKey, Constants.light);
    } else {
      themeMode = box.get(_themeKey) == Constants.light ? ThemeMode.light : ThemeMode.dark;
    }

    print("[SettingsLocalDataSource] App theme mode: ${box.get(_themeKey)}");
    return themeMode;
  }

  Future<void> switchThemeMode({required ThemeMode themeMode}) async{
    var box = await Hive.openBox(_themeBoxName);
    box.put(_themeKey, themeMode == ThemeMode.dark ? Constants.light : Constants.dark);

    print("[SettingsLocalDataSource] App theme mode switched to: ${box.get(_themeKey)}");
  }

  Future<String> getDateCulture() async{
    var box = await Hive.openBox(_dateCultureBoxName);
    String dateCultureCode = Constants.gregorian;

    if(box.isEmpty){
      box.put(_dateCultureKey, dateCultureCode);
    } else {
      dateCultureCode = box.get(_dateCultureKey);
    }

    print("[SettingsLocalDataSource] App Date Culture: $dateCultureCode");
    return dateCultureCode;
  }

  Future<void> switchDateCulture() async{
    var box = await Hive.openBox(_dateCultureBoxName);
    box.put(_dateCultureKey, box.get(_dateCultureKey) == Constants.gregorian ? Constants.hijri : Constants.gregorian);
    final String hijriCalendarLocal = box.get(_dateCultureKey) == Constants.hijri ? Constants.ar : Constants.en;
    HijriCalendar.setLocal(hijriCalendarLocal);

    print("[SettingsLocalDataSource] App Date Culture switched to: ${box.get(_dateCultureKey)}");
  }
}