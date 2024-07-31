import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/features/landing_page/presentation/landingpage.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_snack_bar.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/di/get_di.dart' as di;
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../shared/api/api_keys.dart';
import '../../profile/data/models/level.dart';
import '../data/models/login_credentials.dart';
import '../data/models/user.dart';
import '../data/repositories/authentication_repository.dart';
import '../presentation/screens/login_screen.dart';

class AuthenticationViewModel extends ChangeNotifier {
  static UserModel? _user;
  bool _loading = false;

  UserModel? get userInfo => _user;
  static UserModel? get user => _user;
  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  // Future<void> isAuthenticated({
  //   required context
  // }) async {
  //   try {
  //      changeLoadingStatus(true);
  //     String? userToken = await getUserToken();
  //
  //     if (userToken != null) {
  //       goToHome(context);
  //     } else {
  //       goToLogin(context);
  //       // goToHome(context);
  //     }
  //
  //   } catch (e) {
  //     Navigator.pop(context);
  //     CustomDialog(context).showMessage(
  //       message: Errors.getErrorMessage(exception: e),
  //       action: goToLogin(context),
  //     );
  //   }
  // }

  Future<void> splashInit({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);

      LoginCredentials? credentials = await getUserCredentials();
      if (credentials == null) {
        changeLoadingStatus(false);
        return goToLogin(context);
      }

      await loginByPhoneAndPass(
          phone: credentials.phone,
          password: credentials.password,
          context: context);

         ZegoUIKitPrebuiltCallInvitationService().init(
         appID: Constants.callAppID /*input your AppID*/,
         appSign: Constants.callAppSign /*input your AppSign*/,
         userID: AuthenticationViewModel.user!.personId!, // evaluator
         userName: AuthenticationViewModel.user!.name!, 
         plugins: [ZegoUIKitSignalingPlugin()],
         );
    } catch (e) {
      Navigator.pop(context);
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
        action: goToLogin(context),
      );
    }
  }

  Future<void> loginByPhoneAndPass({
    required context,
    required String phone,
    required String password,
  }) async {
    FocusScope.of(context).unfocus();
    try {
      if (phone.isEmpty || password.isEmpty) {
        throw GeneralExceptions(
            message: AppLocalizations.of(context)!.validation_required);
      }
      changeLoadingStatus(true);

      LoginCredentials credentials =
      LoginCredentials(phone: phone, password: password);
      final data = await loginRequest(credentials: credentials);
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(
          message: AppLocalizations.of(context)!.message_login_failed,
        );
      }

      _user = UserModel.fromJson(json: data);
      await saveUserData(
          personId: _user!.personId!,
          token: _user!.token!,
          credentials: credentials);

      LevelModel level = LevelModel.fromJson(json: data);
      await saveLevelData(
          currentLevelId: "982", currentLevelQuota:  "ورثة الكتاب -سنام القرآن - صيف",);

      String? currentWeekID = data["currentWeekID"];
      await saveCurrentWeekData(
          currentWeekId: currentWeekID);

      if (level.id == null || level.name == null || currentWeekID == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.warning(
            error: AppLocalizations.of(context)!.profile_level_no_active_level,
            context: context,
          ),
        );
      }

      changeLoadingStatus(false);
      goToHome(context);
      // goToLangingpage(context);
    } catch (e) {
      await CustomDialog(context).showMessage(
          message: Errors.getErrorMessage(exception: e),
          action: goToLogin(context));
    } finally {
      changeLoadingStatus(false);
    }
  }

  Future<void> logout({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);

      await logoutRequest();
      print("user token after logout: ${getUserToken()}");
      print("user Credentials after logout: ${getUserCredentials()}");

      changeLoadingStatus(false);
      goToLogin(context);
    } catch (e) {
      await CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

//============================ endpoints =============================//
  Future<String?> getUserToken() async {
    return await di.getItInstance<AuthenticationRepository>().getUserToken();
  }

  Future<LoginCredentials?> getUserCredentials() async {
    return await di
        .getItInstance<AuthenticationRepository>()
        .getUserCredentials();
  }

  Future<Map<String, dynamic>> loginRequest(
      {required LoginCredentials credentials}) async {
    return await di
        .getItInstance<AuthenticationRepository>()
        .login(credentials: credentials);
  }

  Future<void> saveUserData({
    required String personId,
    required String token,
    required LoginCredentials credentials,
  }) async {
    await di.getItInstance<AuthenticationRepository>().saveUserData(
      personId: personId,
      token: token,
      credentials: credentials,
    );
  }

  Future<void> saveLevelData({
    required String? currentLevelId,
    required String? currentLevelQuota,
  }) async {
    await di.getItInstance<AuthenticationRepository>().saveLevelData(
      currentLevelId: currentLevelId,
      currentLevelQuota: currentLevelQuota,
    );
  }

  Future<void> saveCurrentWeekData({
    required String? currentWeekId,
  }) async {
    await di.getItInstance<AuthenticationRepository>().saveWeekData(
      currentWeekId: currentWeekId,
    );
  }

  Future<void> logoutRequest() async {
    await di.getItInstance<AuthenticationRepository>().logout();
  }

//============================ helpers =============================//
  goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  goToLandingPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, LandingPage.routeName, (route) => false);
  }

  goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}