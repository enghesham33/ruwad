import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class DailyTasksRemoteDataSource {
  Dio dio = Dio();

  Future<Map<String, dynamic>> loadDailyTasks({
    required DateTime date,
  }) async {
    print("loadDailyTasks");
    final data = await ApiBaseHelper.get(
        url: ApiEndpoints.getDailyTasks,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        ApiKeys.dayDate: DateFormat('dd-MM-yyyy').format(date),
        ApiKeys.currentLevelId: HomeViewModel.level?.id,
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
      }
    );
    return data;
  }

  Future<Map<String, dynamic>> incrementTask({
    required int taskId,
  }) async {
    final data = await ApiBaseHelper.post(
        url: ApiEndpoints.postIncrementTask,
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
          ApiKeys.taskId: taskId,
        }
    );

    return data;
  }

  Future<Map<String, dynamic>> setTaskScore({
    required int taskId,
    required int score
  }) async {
    final data = await ApiBaseHelper.post(
        url: ApiEndpoints.postSetTaskScore,
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
          ApiKeys.taskId: taskId.toString(),
          "userScore": score.toString(),
        }
    );
    return data;
  }

  Future<Map<String, dynamic>> resetTask({
    required DateTime date,
    required int taskId,
  }) async {
    final data = await ApiBaseHelper.post(
        url: ApiEndpoints.postResetTask,
        headers: {
          ApiKeys.accept: ApiValues.acceptValue,
          ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
          ApiKeys.dayDate: DateFormat('dd-MM-yyyy').format(date),
          ApiKeys.currentLevelId: HomeViewModel.level?.id,
          ApiKeys.personId: AuthenticationViewModel.user?.personId,
          ApiKeys.taskId: taskId,
        }
    );

    return data;
  }

}