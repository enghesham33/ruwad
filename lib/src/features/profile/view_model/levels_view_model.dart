import 'package:flutter/cupertino.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/enums.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../../../shared/di/get_di.dart' as di;
import '../data/models/certificate.dart';
import '../data/repositories/profile_repository.dart';

class LevelsViewModel extends ChangeNotifier {
  static CertificateModel? _certificate;
  static LevelModel? _level;
  bool _loading = false;

  CertificateModel? get certificate => _certificate;

  LevelModel? get level => _level;

  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  Future<void> loadLevelDetails({
    required context,
    required String levelID,
  }) async {
    try {
      changeLoadingStatus(true);

      final data = await di
          .getItInstance<ProfileRepository>()
          .loadLevelDetails(levelID: levelID);
      _level = LevelModel.fromJson(json: data);
      _certificate = CertificateModel.fromJson(json: data);

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
