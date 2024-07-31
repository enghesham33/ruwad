import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class LoginCredentials {
  String phone;
  String password;

  LoginCredentials({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
    ApiKeys.phone: phone,
    ApiKeys.password: password,
  };
}