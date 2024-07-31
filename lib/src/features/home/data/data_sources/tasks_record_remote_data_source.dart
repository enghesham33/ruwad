import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class TasksRecordRemoteDataSource {
  Dio dio = Dio();

  Future<Map<String, dynamic>> loadTasksRecord() async {
    print("loadTasksRecord");
    final data = await ApiBaseHelper.get(
        url: ApiEndpoints.getTasksRecord,
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
          ApiKeys.currentLevelId: HomeViewModel.level?.id,
          ApiKeys.personId: AuthenticationViewModel.user?.personId,
        }
    );
    return data;
  }

}