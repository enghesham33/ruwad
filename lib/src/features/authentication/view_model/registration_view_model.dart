import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:rawdat_hufaz/src/features/authentication/data/models/register_credentials.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_snack_bar.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/di/get_di.dart' as di;
import 'package:rawdat_hufaz/src/shared/enums.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

import '../data/models/batch.dart';
import '../data/models/user.dart';
import '../data/repositories/registration_repository.dart';

class RegistrationViewModel extends ChangeNotifier {
  bool _loading = false;
  static UserModel? _user;
  static String? _firstName;
  static String? _lastName;
  static String? _phoneNumber;
  static String? _password;
  static DateTime? _birthDate;
  static Gender? _gender;
  static num? _batchId;
  static List<BatchModel>? _batches;

  static UserModel? get user => _user;

  String get firstName => _firstName ?? "";

  String get lastName => _lastName ?? "";

  String get phoneNumber => _phoneNumber ?? "";

  String get password => _password ?? "";

  DateTime get birthDate => _birthDate ?? DateTime((DateTime.now().year - 18));

  Gender get gender => _gender ?? Gender.female;

  num get batchId => _batchId ?? 0;

  bool get isLoading => _loading;

  List<BatchModel>? get batches => _batches ?? [];

  loadRegistrationData({
    required context,
  }) async {
    try{
      changeLoadingStatus(true);
      CustomDialog(context).showLoadingSpinner();
      _batches = await loadBatches() ?? [];
      if(_batches!.isEmpty){
        throw GeneralExceptions(message:  AppLocalizations.of(context)!.message_no_batches);
      }
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
        action: () {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (r) => false);
        },
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  setFirstName({required String name}){
    _firstName = name;
    notifyListeners();
  }

  setLastName({required String name}) {
    _lastName = name;
    notifyListeners();
  }

  setPhoneNumber({required String phoneNumber}) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  setPassword({required String password}) {
    _password = password;
    notifyListeners();
  }

  setBirthDate({required DateTime birthDate}) {
    _birthDate = birthDate;
    notifyListeners();
  }

  setGender({required Gender? gender}) {
    _gender = gender;
    notifyListeners();
  }

  setBatchId({required num batchId}) {
    _batchId = batchId;
    notifyListeners();
  }

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  Future<void> registerUser({required context}) async {
    FocusScope.of(context).unfocus();
    try {
      if (_firstName == null ||
          _lastName == null ||
          _phoneNumber == null ||
          _password == null ||
          _birthDate == null ||
          _gender == null ||
          _batchId == null) {
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_registration_required_fields);
      }
      changeLoadingStatus(true);
      final UserModel newUser = UserModel(
        name: "$_firstName $_lastName",
        phone: _phoneNumber,
        birthDate: _birthDate,
        gender: _gender,
      );
      final RegisterCredentials credentials = RegisterCredentials(
        password: _password!,
        user: newUser,
        batchId: _batchId!
      );
      final data = await registerRequest(credentials: credentials);
      if( data[ApiKeys.code] == ApiValues.failedCode){
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_registration_failed);
      }
      _user = newUser;
      _user!.setPersonId(json:  data );
      await savePersonId(personId: _user!.personId!);
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.success(text: AppLocalizations.of(context)!.message_registration_success, context: context)
      );
      goToLogin(context);
    } catch (e) {
      await CustomDialog(context).showMessage(
          message: Errors.getErrorMessage(exception: e),
          action: goToLogin(context)
      );
    } finally {
      changeLoadingStatus(false);
    }
  }

  //============================ endpoints =============================//
  Future<Map<String, dynamic>> registerRequest({required RegisterCredentials credentials}) async {
    return await di.getItInstance<RegistrationRepository>().registerUser(credentials: credentials);
  }

  Future<void> savePersonId({required String personId}) async {
    await di.getItInstance<RegistrationRepository>().savePersonId(personId: personId);
  }

  Future<List<BatchModel>?> loadBatches() async {
    return await di.getItInstance<RegistrationRepository>().loadBatches();
  }

  //============================ helpers =============================//
  goToHome(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
  }

  goToLogin(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
  }
}