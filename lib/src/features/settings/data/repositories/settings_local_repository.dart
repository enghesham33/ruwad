import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/settings/data/data_sources/settings_local_data_source.dart';

class SettingsLocalRepository {
  SettingsLocalRepository({required this.localDataSource});

  final SettingsLocalDataSource localDataSource;

  Future<String> getLanguage() async{
    return localDataSource.getLanguage();
  }

  Future<void> switchLanguage() async{
    return localDataSource.switchLanguage();
  }

  Future<ThemeMode> getThemeMode() async{
    return localDataSource.getThemeMode();
  }

  Future<void> switchThemeMode({required ThemeMode themeMode}) async{
    return localDataSource.switchThemeMode(themeMode: themeMode);
  }

  Future<String> getDateCulture() async{
    return localDataSource.getDateCulture();
  }

  Future<void> switchDateCulture() async{
    return localDataSource.switchDateCulture();
  }
}