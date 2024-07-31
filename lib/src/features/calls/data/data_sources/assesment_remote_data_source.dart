import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/oral_assesment_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/week_assesment_model.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';


class AssesmentRemoteDataSource {
  Dio dio = Dio();

  Future<Map<String, dynamic>> postWeekAssesment({
    required WeekAssesmentModel evaluation,
  }) async {
    final data = await ApiBaseHelper.post(
      url: ApiEndpoints.postWeekAssesment,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
      },
      data: evaluation.toJson(),
    );
    return data;
  }

    Future<Map<String, dynamic>> postOralAssesment({
    required OralAssesmentModel evaluation,
  }) async {
    final data = await ApiBaseHelper.post(
      url: ApiEndpoints.postOralAssesment,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
      },
      data: evaluation.toJson(),
    );
    return data;
  }

}
