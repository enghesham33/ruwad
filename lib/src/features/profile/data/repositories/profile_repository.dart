import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data_sources/profile_remote_data_source.dart';
import '../models/level.dart';

class ProfileRepository{
  ProfileRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final ProfileRemoteDataSource remoteDataSource;

  Future<UserModel> loadProfile() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadProfile();
  }

  Future<void> updateProfile({
    required String phone,
    required String idNumber,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.updateProfile(
        phone: phone, idNumber: idNumber);
  }

  Future<List<LevelModel>> loadLevels() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadLevels();
  }

  Future<Map<String, dynamic>> loadLevelDetails({
    required String levelID,
  }) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadLevelDetails(levelID: levelID);
  }
}