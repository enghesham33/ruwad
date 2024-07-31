import 'package:hive/hive.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';

class HomeLocalDataSource {
  final String _levelBoxName = "levelBox";
  final String _currentLevelId = "currentLevelId";
  final String _currentLevelQuota = "currentLevelQuota";

  final String _weekBoxName = "weekBox";
  final String _currentWeekId = "currentWeekId";

  Future<LevelModel?> getCurrentLevel() async {
    try {
      var box = await Hive.openBox(_levelBoxName);

      String? levelId = box.get(_currentLevelId);
      String? levelName = box.get(_currentLevelQuota);
      if (levelId == null || levelName == null ){
        return null;
      }
      return LevelModel(id: box.get(_currentLevelId), name: box.get(_currentLevelQuota));
    } catch (e) {
      return null;
    }
  }

  Future<num?> getCurrentWeekData() async {
    try {
      var box = await Hive.openBox(_weekBoxName);

      num? weekId = num.tryParse( await box.get(_currentWeekId));
      if (weekId == null ){
        return null;
      }
      return weekId;
    } catch (e) {
      return null;
    }
  }
}
