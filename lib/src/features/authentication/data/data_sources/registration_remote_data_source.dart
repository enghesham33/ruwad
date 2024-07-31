import 'package:intl/intl.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/register_credentials.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/password_encryption.dart';
import '../models/batch.dart';

class RegistrationRemoteDataSource {
  Future<List<BatchModel>?> loadBatches() async {
    final data = await ApiBaseHelper.get(url: ApiEndpoints.getBatches);
    List<BatchModel> batchesList = (data["items"] as List)
        .map((data) => BatchModel.fromJson(json: data))
        .toList();
    return batchesList;
  }

  Future<Map<String, dynamic>> registerUser(
      {required RegisterCredentials credentials}) async {
    final data = await ApiBaseHelper.post(
        url: ApiEndpoints.postRegister,
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
          ApiKeys.batchId: credentials.batchId,
          ApiKeys.birthDate: DateFormat('dd-MM-yyyy').format(credentials.user.birthDate!),
          ApiKeys.gender: credentials.user.gender.toString().split('.').last,
          ApiKeys.phone: credentials.user.phone,
          ApiKeys.name: credentials.user.name,
          ApiKeys.password: encryptPassword(credentials.password),
        },
        // data: credentials.toJson()
    );
    // UserModel user = credentials.user;
    // user.setPersonId(json: data);
    // return user;
    return data;
  }
}