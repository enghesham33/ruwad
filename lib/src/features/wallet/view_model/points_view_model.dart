import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/models/point_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/repositories/wallet_repository.dart';
import '../../../shared/di/get_di.dart' as di;

class PointsViewModel with ChangeNotifier {
  bool _loading = false;
  bool get isLoading => _loading;


  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

//Evaluator eran point on accept call --moved to BE
Future earnRecitePoints() async
{
  PointsModel points = PointsModel
  (
    personalID: AuthenticationViewModel.user?.personId??'',
    cardType: 3,
    points: 10
  );  
  await di.getItInstance<WalletRepository>().postEarnPoints(points: points);
}

Future consumePoints() async
{
  PointsModel points = PointsModel
  (
    personalID: AuthenticationViewModel.user?.personId??'',
    cardType: 3,
    points: 10
  );  
  await di.getItInstance<WalletRepository>().postConsumePoints(points: points);
}
  
}