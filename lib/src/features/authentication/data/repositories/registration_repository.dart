import 'package:rawdat_hufaz/src/features/authentication/data/data_sources/registration_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/register_credentials.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data_sources/registration_local_data_source.dart';
import '../models/batch.dart';

class RegistrationRepository {
  RegistrationRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final RegistrationRemoteDataSource remoteDataSource;
  final RegistrationLocalDataSource localDataSource;

  Future<List<BatchModel>?> loadBatches() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadBatches();
  }

  Future<Map<String, dynamic>> registerUser({required RegisterCredentials credentials}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.registerUser(credentials: credentials);
  }

  Future<void> savePersonId({required String personId}) async {
    await localDataSource.savePersonId(personId: personId);
  }
}
