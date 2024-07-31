import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data_sources/exam_remote_data_source.dart';

class ExamsRepository {
  ExamsRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final ExamRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> submitExam({required List<Map<String, dynamic>> answers}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.submitExam(answers: answers);
  }

   Future<Map<String, dynamic>> getExamsAndScores() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.getExamsAndScores();
  }

    Future<Map<String, dynamic>> getExamDetails({required int examID}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.getExamDetails(examID:examID );
  }
}
