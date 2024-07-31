import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/home/data/models/task.dart';
import 'package:rawdat_hufaz/src/features/home/data/repositories/daily_tasks_repository.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../../../shared/di/get_di.dart' as di;
import '../data/models/day.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'home_view_model.dart';

class DailyTasksViewModel extends ChangeNotifier{
  static DayModel? _day;
  static List<TaskModel> _tasks = [];
  bool _loading = false;

  DayModel get day => _day!;
  List<TaskModel> get tasks => [..._tasks];
  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  Future<void> loadDayData({
    required context,
    required DateTime date
  }) async {
    try {
      changeLoadingStatus(true);

      if (HomeViewModel.level?.id == null) {
        print("HomeViewModel.level?.id == null");
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_title_activate_level );
      }

      final data = await di.getItInstance<DailyTasksRepository>().loadDailyTasks(date: date);

      if (data["code"] == 1) {
        _day = null;
        _tasks = [];
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_title_activate_level );
      }

      _day = DayModel.fromJson(date: date, json: data);
      _tasks = (data[ApiKeys.tasks] as List)
          .map((data) {
        return TaskModel.fromJson(json: data);
      }).toList();
      
      changeLoadingStatus(false);
    }
    // catch (e) {
    //   CustomDialog(context).showMessage(
    //     message: Errors.getErrorMessage(exception: e),
    //   );
    // }
    finally {
      changeLoadingStatus(false);
    }
  }

  Future<void> incrementScore({
    required context,
    required int taskID,
  }) async {
    try {
      final int taskIndex = _tasks.indexWhere((element) => element.id == taskID);
      final data = await di.getItInstance<DailyTasksRepository>().incrementTask(taskId: taskID);
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _tasks[taskIndex].userRepetitions = data[ApiKeys.repetitions];
      _day!.userScore = double.parse(data[ApiKeys.userScore].toString());

      notifyListeners();
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  Future<void> resetTask({
    required context,
    required int taskID,
  }) async {
    try {
      final int taskIndex = _tasks.indexWhere((element) => element.id == taskID);
      final data = await di.getItInstance<DailyTasksRepository>().resetTask(taskId: taskID, date: _day!.date);
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _tasks[taskIndex].userRepetitions = data[ApiKeys.repetitions];
      _day!.userScore = double.parse(data[ApiKeys.userScore].toString());

      notifyListeners();
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  Future<void> submitTaskScore({
    required context,
    required int taskID,
    required int score,
  }) async {
    try {
      final int taskIndex = _tasks.indexWhere((element) => element.id == taskID);
      final data = await di.getItInstance<DailyTasksRepository>().setTaskScore(taskId: taskID, score: score);
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _tasks[taskIndex].userRepetitions = data["repetitions"];
      _day!.userScore = double.parse(data["score"].toString());

      notifyListeners();
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }
}