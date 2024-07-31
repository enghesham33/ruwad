import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';

import '../data_sources/home_local_data_source.dart';

class HomeRepository {
  HomeRepository({
    required this.localDataSource,
  });

  final HomeLocalDataSource localDataSource;

  Future<LevelModel?> getCurrentLevel() async {
    return await localDataSource.getCurrentLevel();
  }

  Future<num?> getCurrentWeekData() async {
    return await localDataSource.getCurrentWeekData();
  }

}