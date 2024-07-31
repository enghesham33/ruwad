import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';
import 'package:rawdat_hufaz/src/features/home/data/repositories/home_repository.dart';
import '../../../shared/alerts/custom_dialogs.dart';
import '../../../shared/di/get_di.dart' as di;
import '../../../shared/errors/exceptions.dart';

class HomeViewModel extends ChangeNotifier{
  static LevelModel? _currentLevel;
  static num? _currentWeekID;
  bool _loading = false;

  LevelModel? get currentLevel => _currentLevel;
  num? get currentWeekID => _currentWeekID;
  static LevelModel? get level => _currentLevel;
  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  loadHomeData({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);
      _currentLevel = await getCurrentLevel();
      if(_currentLevel == null){
        print("[loadHomeData] _currentLevel == null");
      }

      _currentWeekID = await getCurrentWeekData();
      if (_currentWeekID == null) {
        print("[loadHomeData] _currentWeekID == null");
      }

      changeLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  //============================ endpoints =============================//
  Future<LevelModel?> getCurrentLevel() async {
    return await di.getItInstance<HomeRepository>().getCurrentLevel();
  }

  Future<num?> getCurrentWeekData() async {
    return await di.getItInstance<HomeRepository>().getCurrentWeekData();
  }
}

