import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  Future<bool> get isNotConnected => _isConnected();

  Future<bool> _isConnected() async {
    return await (Connectivity().checkConnectivity()).then(
        (connectivityResult) =>
            connectivityResult == ConnectivityResult.none ? true : false);
  }
}
