import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/password_encryption.dart';

import '../models/login_credentials.dart';

class AuthenticationRemoteDataSource {
  Dio dio = Dio();

  // Future<Map<String, dynamic>> login({
  //   required LoginCredentials credentials,
  // }) async {
  //   final data = await ApiBaseHelper.post(
  //     url: ApiEndpoints.postLogin,
  //     headers: {
  //       ApiKeys.accept: ApiValues.acceptValue,
  //       ApiKeys.phone: credentials.phone,
  //       ApiKeys.password: credentials.password,
  //     },
  //     // data: credentials.toJson(),
  //   );
  //   return data;
  // }

  Future<Map<String, dynamic>> login({
    required LoginCredentials credentials,
  }) async {
    final response = await dio.post(
      ApiEndpoints.postLogin,
      data: {}, // credentials.toJson(),
      options: Options(
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
         ApiKeys.phone: "0512345678",
          // ApiKeys.password: encryptPassword(credentials.password),
          ApiKeys.password: "123456",
        },
      ),
    );
    print('[AuthenticationRemoteDataSource] post method response headers: ${response.headers}');
    print("[AuthenticationRemoteDataSource] post method response data: ${response.data.toString()}");
    Map<String, dynamic> data = response.data;
    if( data[ApiKeys.code].toString() == ApiValues.successCode){
      data['sessiontoken'] = response.headers["sessiontoken"]!.first ;
      print('[AuthenticationRemoteDataSource] sessiontoken: ${data['sessiontoken']}');
    }
    print("[AuthenticationRemoteDataSource] new data: ${data.toString()}");
    return data;
  }

}
