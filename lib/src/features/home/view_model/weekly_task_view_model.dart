import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data/models/weekly_task.dart';
import '../../../shared/di/get_di.dart' as di;
import '../data/repositories/weekly_task_repository.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'home_view_model.dart';

class WeeklyTaskViewModel extends ChangeNotifier {
  static WeeklyTaskModel? _weeklyTask;
  bool _loading = false;

  WeeklyTaskModel? get weeklyTask => _weeklyTask;
  bool get isLoading => _loading;

  final DateTime today = DateTime.now();

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  loadWeeklyTaskData({
    required context,
    required num? weekID
  }) async{
    try {
      changeLoadingStatus(true);

      if(weekID == null || HomeViewModel.level?.id == null){
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_title_activate_level);
      }

      final data = await di.getItInstance<WeeklyTaskRepository>().loadWeeklyTask(weekID: weekID);
      _weeklyTask = WeeklyTaskModel.fromJson(json: data);

      changeLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }
}