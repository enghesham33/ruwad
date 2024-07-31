import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data_sources/authentication_local_data_source.dart';
import '../data_sources/authentication_remote_data_source.dart';
import '../models/login_credentials.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;

  Future<Map<String, dynamic>> login({required LoginCredentials credentials}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.login(credentials: credentials);
  }

  Future<void> saveUserData({
    required String personId,
    required String token,
    required LoginCredentials credentials,
  }) async {
    await localDataSource.saveUserData(
        personId: personId,
        token: token,
        credentials: credentials
    );
  }

  Future<void> saveLevelData({
    required String? currentLevelId,
    required String? currentLevelQuota,
  }) async {
    await localDataSource.saveLevelData(
      currentLevelId: currentLevelId,
      currentLevelQuota: currentLevelQuota,
    );
  }

  Future<void> saveWeekData({
    required String? currentWeekId,
  }) async {
    await localDataSource.saveWeekData(
      currentWeekId: currentWeekId,
    );
  }

  Future<String?> getUserToken() async {
    return await localDataSource.getUserToken();
  }

  Future<LoginCredentials?> getUserCredentials() async {
    return await localDataSource.getUserCredentials();
  }

  Future<void> logout() async {
    await localDataSource.logout();
  }
}
