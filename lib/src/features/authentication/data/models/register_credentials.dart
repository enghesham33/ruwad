import 'package:intl/intl.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class RegisterCredentials {
  final UserModel user;
  final String password;
  final num batchId;

  RegisterCredentials(
      {required this.user, required this.password, required this.batchId});

  Map<String, dynamic> toJson() => {
        ApiKeys.batchId: batchId.toString(),
        ApiKeys.birthDate: DateFormat('yyyy/MM/dd').format(user.birthDate!),
        ApiKeys.gender: user.gender.toString().toString().split('.').last,
        ApiKeys.phone: user.phone,
        ApiKeys.name: user.name,
        ApiKeys.password: password
      };
}