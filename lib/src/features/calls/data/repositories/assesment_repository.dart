import 'package:rawdat_hufaz/src/features/calls/data/data_sources/assesment_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/oral_assesment_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/week_assesment_model.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

class AssesmentRepository {
  AssesmentRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final AssesmentRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> postWeekAssesment({required WeekAssesmentModel evaluation}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.postWeekAssesment(evaluation: evaluation);
  }

    Future<Map<String, dynamic>> postOralAssesment({required OralAssesmentModel evaluation}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.postOralAssesment(evaluation: evaluation);
  }


}