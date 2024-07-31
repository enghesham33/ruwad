import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

class ProfileRemoteDataSource {
  Dio dio = Dio();

  Future<UserModel> loadProfile() async {
    final data =
        await ApiBaseHelper.get(url: ApiEndpoints.getProfile, headers: {
      ApiKeys.accept: ApiValues.acceptValue,
      ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
      ApiKeys.personId: AuthenticationViewModel.user?.personId,
    });
    UserModel user = UserModel.fromJson(json: data);
    return user;
  }

  Future<void> updateProfile({
    required String phone,
    required String idNumber,
  }) async {
    final data =
        await ApiBaseHelper.post(url: ApiEndpoints.postUpdateProfile, headers: {
      ApiKeys.accept: ApiValues.acceptValue,
      ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
      "personID": AuthenticationViewModel.user?.personId,
      "mobileNumber": phone,
      "IDNumber": idNumber,
    });

    if (data[ApiKeys.code] == ApiValues.failedCode) {
      throw GeneralExceptions(message: data[ApiKeys.message]);
    }
  }

  Future<List<LevelModel>> loadLevels() async {
    final data = await ApiBaseHelper.get(
      url: ApiEndpoints.getLevels,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
      },
    );
    List<LevelModel> levels = (data["levels"] as List)
        .map((data) => LevelModel.fromJson(json: data))
        .toList();
    return levels;
  }

  Future<Map<String, dynamic>> loadLevelDetails({
    required String levelID,
  }) async {
    final data = await ApiBaseHelper.get(
      url: ApiEndpoints.getLevelDetails,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
        "levelID": levelID,
      },
    );
    return data;
  }
}
