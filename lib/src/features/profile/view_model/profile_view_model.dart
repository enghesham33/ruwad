import 'package:flutter/cupertino.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../../../shared/di/get_di.dart' as di;
import '../data/repositories/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  static UserModel? _user;
  static List<LevelModel> _levels = [];
  static String? _phoneInput;
  static String? _idNumberInput;
  bool _loading = false;

  UserModel? get user => _user;

  List<LevelModel> get levels => [..._levels];

  String? get phoneInput => _phoneInput;

  String? get idNumberInput => _idNumberInput;

  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  setPhoneInput({required String? phone}) {
    if (phone == null || phone.trim().isEmpty) {
      return;
    }
    _phoneInput = phone;
    notifyListeners();
  }

  setIDNumberInput({required String? idNumber}) {
    if (idNumber == null || idNumber.trim().isEmpty) {
      return;
    }
    _idNumberInput = idNumber;
    notifyListeners();
  }

  Future<void> loadProfileData({required context}) async {
    try {
      changeLoadingStatus(true);

      _user = await di.getItInstance<ProfileRepository>().loadProfile();
      _levels = await di.getItInstance<ProfileRepository>().loadLevels();

      setPhoneInput(phone: _user!.phone);
      setIDNumberInput(idNumber: _user!.idNumber);
      changeLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  Future<void> updateProfile({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);

      await di
          .getItInstance<ProfileRepository>()
          .updateProfile(phone: _phoneInput!, idNumber: _idNumberInput!);
      _user!.setIdNumber(idNumber: _idNumberInput!);
      _user!.setPhone(phone: _phoneInput!);
      await loadProfileData(context: context);

      changeLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }
}
