import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data_sources/weekly_task_remote_data_source.dart';

class WeeklyTaskRepository {
  WeeklyTaskRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final WeeklyTaskRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> loadWeeklyTask({
    required num weekID
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadWeeklyTask(weekID: weekID);
  }
}
