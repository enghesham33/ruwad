import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import '../../../../shared/api/api_keys.dart';
import '../../../authentication/view_model/authentication_view_model.dart';
import '../../../home/view_model/home_view_model.dart';

class ExamRemoteDataSource {
  Dio dio = Dio();

  Future<Map<String, dynamic>> getExamsAndScores() async {
    final data =
        await ApiBaseHelper.get(
            url: ApiEndpoints.getExamsAndScores,
            headers: {
              ApiKeys.accept: ApiValues.acceptValue,
              ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
              ApiKeys.currentLevelId: HomeViewModel.level?.id,
              ApiKeys.personId: AuthenticationViewModel.user?.personId,
            },
        );
    return data;
  }

  Future<Map<String, dynamic>> getExamDetails({required int examID}) async {
    final data =
        await ApiBaseHelper.get(
            url: ApiEndpoints.getExamDetails,
            headers: {
              ApiKeys.accept: ApiValues.acceptValue,
              ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
              ApiKeys.currentLevelId: HomeViewModel.level?.id,
              ApiKeys.personId: AuthenticationViewModel.user?.personId,
              ApiKeys.examID: examID.toString(),
            },
        );
    return data;
  }

  Future<Map<String, dynamic>> submitExam({
    required List<Map<String, dynamic>> answers,
  }) async {
    final data = await ApiBaseHelper.post(
      url: ApiEndpoints.postSubmitExam,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
      },
      data: {
        ApiKeys.currentLevelId: HomeViewModel.level?.id,
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
        "questions": answers
      },
    );
    return data;
  }
}
