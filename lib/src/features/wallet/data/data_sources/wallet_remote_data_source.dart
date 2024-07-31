import 'package:dio/dio.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/models/point_model.dart';
import 'package:rawdat_hufaz/src/shared/api/api_base_helper.dart';
import 'package:rawdat_hufaz/src/shared/api/api_endpoints.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class WalletRemoteDataSource {
  Dio dio = Dio();

  Future<Map<String, dynamic>> loadWallet() async {
    final data = await ApiBaseHelper.get(
      url: ApiEndpoints.getPoints,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        'personID': AuthenticationViewModel.user?.personId
      },
      // data: {
      //   ApiKeys.personId: 4321, //AuthenticationViewModel.user?.personId,
      // },
    );
    return data;
  }

    Future<Map<String, dynamic>> postEarnPoints({
    required PointsModel points,
    }) async {
    final data = await ApiBaseHelper.post(
      url: ApiEndpoints.postEarnPoints,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
        ApiKeys.points:points.points,
        ApiKeys.cardType:points.cardType
      }
    );
    return data;
  }
    Future<Map<String, dynamic>> postConsumePoints({
    required int points, required int cardType
    }) async {
    final data = await ApiBaseHelper.post(
      url: ApiEndpoints.postConsumePoints,
      headers: {
        ApiKeys.accept: ApiValues.acceptValue,
        ApiKeys.authorization: "Bearer ${AuthenticationViewModel.user?.token}",
        ApiKeys.personId: AuthenticationViewModel.user?.personId,
        'points':points.toString(),
        'cardType':cardType.toString()
      },
      data: {}
    );
    return data;
  }
}