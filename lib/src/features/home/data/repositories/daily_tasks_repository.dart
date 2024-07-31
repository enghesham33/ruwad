import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data_sources/daily_tasks_remote_data_source.dart';

class DailyTasksRepository {
  DailyTasksRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final DailyTasksRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> loadDailyTasks({
    required DateTime date,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadDailyTasks(date: date);
  }

  Future<Map<String, dynamic>> incrementTask({
    // required DateTime date,
    required int taskId,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.incrementTask(taskId: taskId);
    // return await remoteDataSource.incrementTask(taskId: taskId, date: date);
  }

  Future<Map<String, dynamic>> setTaskScore({
    required int taskId,
    required int score,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.setTaskScore(taskId: taskId, score: score);
  }

  Future<Map<String, dynamic>> resetTask({
    required DateTime date,
    required int taskId,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.resetTask(taskId: taskId, date: date);
  }
}
