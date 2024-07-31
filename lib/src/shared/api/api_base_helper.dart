import 'package:dio/dio.dart';

import '../../features/authentication/view_model/authentication_view_model.dart';
import 'api_keys.dart';

class ApiBaseHelper {
  static get(
      {required String url,
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers}) async {
    Dio dio = Dio();
    print('[ApiBaseHelper] headers sent by get method: $headers');
    var response = await dio.get(
      url,

      data: data ?? {},
      queryParameters: queryParameters ?? {},
      options: Options(
        headers: headers ?? {
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}"
        },
      ),
    );
    print("[ApiBaseHelper] get method response: $response");
    return response.data;
  }

  static post(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        Map<String?, dynamic>? data}) async {
    Dio dio = Dio();
    print('[ApiBaseHelper] queryParameters sent by post method: $queryParameters');
    print('[ApiBaseHelper] data sent by post method: $data');
    print('[ApiBaseHelper] headers sent by post method: $headers');
    var response = await dio.post(
      url,
      queryParameters: queryParameters ?? {},
      data: data ?? {},
      options: Options(
        headers: headers ?? {
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        },
      ),
    );
    print("[ApiBaseHelper] post method response: ${response.data}");
    return response.data;
  }
}
