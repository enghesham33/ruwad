import 'package:rawdat_hufaz/src/features/wallet/data/models/point_model.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data_sources/wallet_remote_data_source.dart';

class WalletRepository {
  WalletRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final WalletRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> loadWallet() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.loadWallet();
  }

    Future<Map<String, dynamic>> postEarnPoints({required PointsModel points}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.postEarnPoints(points: points);
   }

    Future<Map<String, dynamic>> postConsumePoints({required PointsModel points}) async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    return await remoteDataSource.postConsumePoints(points: int.parse(points.points.toString()), cardType:points.cardType);
   }
}
