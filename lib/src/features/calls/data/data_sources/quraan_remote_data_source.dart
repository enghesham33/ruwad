import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';


class QuraanRemoteDataSource
{
  Dio dio = Dio();

    Future<Map<String, dynamic>> getQuraansurah() async {
    final data = await ApiBaseHelper.get(
      url: ApiEndpoints.surah,

    );

    return data;

  }

}






