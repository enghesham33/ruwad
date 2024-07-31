import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data_sources/tasks_record_remote_data_source.dart';

class TasksRecordRepository {
  TasksRecordRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final TasksRecordRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> loadTasksRecord() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadTasksRecord();
  }
}
