import 'package:rawdat_hufaz/src/features/calls/data/data_sources/quraan_remote_data_source.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

class QuraanRepository {
  QuraanRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final QuraanRemoteDataSource remoteDataSource;

   Future<Map<String, dynamic>> getQuraansurah() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.getQuraansurah();
  }

}
