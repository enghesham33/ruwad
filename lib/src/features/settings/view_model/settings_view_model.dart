import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rawdat_hufaz/src/features/settings/data/repositories/settings_local_repository.dart';
import '../../../shared/constants.dart';
import '../../../shared/di/get_di.dart' as di;
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsViewModel extends ChangeNotifier {
  static String? _currentLanguage;
  static ThemeMode? _currentTheme;
  static String? _currentDateCulture;

  String get currentLanguage => _currentLanguage!; //"ar"
  ThemeMode get currentTheme => _currentTheme!;
  String get currentDateCulture => _currentDateCulture!; //"hijri"

  static init() async {
    _currentLanguage = await di.getItInstance<SettingsLocalRepository>().getLanguage();
    _currentTheme = await di.getItInstance<SettingsLocalRepository>().getThemeMode();
    _currentDateCulture = await di.getItInstance<SettingsLocalRepository>().getDateCulture();
  }

  void switchLanguage() async {
    await di.getItInstance<SettingsLocalRepository>().switchLanguage();
    _currentLanguage = await di.getItInstance<SettingsLocalRepository>().getLanguage();
    notifyListeners();
  }

  bool isEnglish() {
    return _currentLanguage == Constants.en;
  }

  void switchThemeMode() async {
    await di.getItInstance<SettingsLocalRepository>().switchThemeMode(themeMode: currentTheme);
    _currentTheme = await di.getItInstance<SettingsLocalRepository>().getThemeMode();
    notifyListeners();
  }

  bool isDarkMode() {
    return _currentTheme == ThemeMode.dark;
  }

  void switchDateCulture() async {
    await di.getItInstance<SettingsLocalRepository>().switchDateCulture();
    _currentDateCulture = await di.getItInstance<SettingsLocalRepository>().getDateCulture();
    notifyListeners();
  }

  String getCulturedDay({required DateTime date, required BuildContext context}) {
    final String day = DateFormat('EEEE').format(date).toLowerCase();
    switch (day) {
      case "sunday":
        {
          return AppLocalizations.of(context)!.sunday;
        }
      case "monday":
        {
          return AppLocalizations.of(context)!.monday;
        }
      case "tuesday":
        {
          return AppLocalizations.of(context)!.tuesday;
        }
      case "wednesday":
        {
          return AppLocalizations.of(context)!.wednesday;
        }
      case "thursday":
        {
          return AppLocalizations.of(context)!.thursday;
        }
      case "friday":
        {
          return AppLocalizations.of(context)!.friday;
        }
      case "saturday":
        {
          return AppLocalizations.of(context)!.saturday;
        }
      default:
        {
          return day;
        }
    }
  }

  String getCulturedDate({required DateTime date}) {
    return _currentDateCulture == Constants.hijri
        ? HijriCalendar.fromDate(date).toFormat('yyyy/mm/dd')
        : DateFormat('dd/MM/yyyy').format(date);
  }

  bool isHijri() {
    return _currentDateCulture == Constants.hijri;
  }
}
