import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/home/data/models/week.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data/repositories/tasks_record_repository.dart';
import '../../../shared/di/get_di.dart' as di;
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'home_view_model.dart';

class TasksRecordViewModel extends ChangeNotifier {
  static List<WeekModel> _weeks = [];
  static int? _activeTabIndex;
  bool _loading = false;

  List<WeekModel> get weeks => [..._weeks];
  int get activeTabIndex => _activeTabIndex!;
  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  Future<void> loadTasksRecord({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);

      if (HomeViewModel.level?.id == null) {
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_title_activate_level );
      }

      final data = await di.getItInstance<TasksRecordRepository>().loadTasksRecord();
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _weeks = ( data[ApiKeys.weeks] as List)
          .map((week) {
        return WeekModel.fromJson(json: week);
      }).toList();

      changeLoadingStatus(false);
    } catch (e) {
      print("[TasksRecordViewModel : loadTasksRecord] $e");
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: AppLocalizations.of(context)!.message_title_activate_level),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  setTab( int index ){
    _activeTabIndex = index;
  }

  int initialTabIndex() {
    final DateTime today = DateTime.now();
    final DateTime todayDate = DateTime(today.year, today.month, today.day);
    try{
    // user landed on a week tab -> display the week the user was at
    int weekIndex = 0;
    if (_activeTabIndex != null ){
      return activeTabIndex;
    }
    // user opens the records screen for the first time -> display active week
      WeekModel week = _weeks.firstWhere((week) {
        if( todayDate == week.endDate || todayDate == week.startDate ){
          return true;
        }
        return todayDate.isAfter(week.startDate!) && todayDate.isBefore(week.endDate!);
      });
      weekIndex = _weeks.indexOf(week);
      setTab( weekIndex );
      return weekIndex;
    }catch(error){
      print("[TasksRecordViewModel] date $todayDate is not within range of weeks");
      setTab( 0 );
      return 0;
    }
  }
}