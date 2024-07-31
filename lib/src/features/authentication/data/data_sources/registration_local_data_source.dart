import 'package:hive/hive.dart';

class RegistrationLocalDataSource {
  final String _userBoxName = "userBox";
  final String _personId = "personId";


  Future savePersonId({required String personId}) async {
    var box = await Hive.openBox(_userBoxName);

    await box.put(_personId, personId);
  }

  Future<String?> getPersonId() async {
    try {
      var box = await Hive.openBox(_userBoxName);

      return box.get(_personId);
    } catch (e) {
      return null;
    }
  }
}