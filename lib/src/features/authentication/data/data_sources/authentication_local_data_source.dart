import 'package:hive/hive.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/login_credentials.dart';

class AuthenticationLocalDataSource {
  final String _userBoxName = "userBox";
  final String _userToken = "userToken";
  final String _personId = "personId";
  final String _phone = "phone";
  final String _password = "password";


  final String _levelBoxName = "levelBox";
  final String _currentLevelId = "currentLevelId";
  final String _currentLevelQuota = "currentLevelQuota";

  final String _weekBoxName = "weekBox";
  final String _currentWeekId = "currentWeekId";


  Future saveUserToken({required String token}) async {
    var box = await Hive.openBox(_userBoxName);

    await box.put(_userToken, token);
  }

  Future<void> saveUserData({
    required String personId,
    required String token,
    required LoginCredentials credentials,
  }) async {
    var box = await Hive.openBox(_userBoxName);

    await box.put(_userToken, token);
    await box.put(_personId, personId);
    await box.put(_phone, credentials.phone);
    await box.put(_password, credentials.password);
  }

  Future<void> saveLevelData({
    required String? currentLevelId,
    required String? currentLevelQuota,
  }) async {
    var box = await Hive.openBox(_levelBoxName);

    await box.put(_currentLevelId, currentLevelId);
    await box.put(_currentLevelQuota, currentLevelQuota);
  }

  Future<void> saveWeekData({
    required String? currentWeekId,
  }) async {
    var box = await Hive.openBox(_weekBoxName);

    await box.put(_currentWeekId, currentWeekId);
    print("AuthenticationLocalDataSource ==> saved week id ${ box.get(_currentWeekId)}");
  }

  Future<String?> getUserToken() async {
    try {
      var box = await Hive.openBox(_userBoxName);

      return box.get(_userToken);
    } catch (e) {
      return null;
    }
  }

  Future<LoginCredentials?> getUserCredentials() async {
    try {
      var box = await Hive.openBox(_userBoxName);
      String? phone = box.get(_phone);
      String? password = box.get(_password);
      if (phone == null || password == null) {
        return null;
      }
      return LoginCredentials(password: box.get(_password), phone: box.get(_phone));
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    var userBox = await Hive.openBox(_userBoxName);
    var levelBox = await Hive.openBox(_levelBoxName);
    userBox.clear();
    levelBox.clear();
  }
}
