import 'package:intl/intl.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/enums.dart';

class UserModel {
  String? idNumber;
  String? name;
  String? phone;
  DateTime? birthDate;
  Gender? gender;
  String? personId;
  String? token;

  UserModel({
    this.name,
    this.phone,
    this.birthDate,
    this.gender,
    this.idNumber = "",
  });

  // int get age => DateTime.now().difference(birthDate!).inDays ~/ 336 ;

  int get age{
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate!.year;
    if (currentDate.month < birthDate!.month ||
        (currentDate.month == birthDate!.month && currentDate.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  String get firstName => name!.split(' ').first;
  String get lastName {
    try{
      return name!.split(' ')[1];
    }catch (e) {
      print("no last name $e");
      return "";
    }
  }

  setPersonId({required Map<String, dynamic> json}){
    personId = json[ApiKeys.personId];
  }

  setIdNumber({required String idNumber}){
    this.idNumber = idNumber;
  }

  setPhone({required String phone}){
    this.phone = phone;
  }

  UserModel.fromJson({required Map<String, dynamic> json}) {
    personId = json[ApiKeys.personId];
    token = json[ApiKeys.sessionToken] ?? "";

    name = json["Name"] ?? json["personName"]??"";
    phone = json["mobileNumber"].toString();
    birthDate = json["birthDate"] != null ? DateFormat("dd-MM-yyyy").parse(json["birthDate"]) : null;
    gender = json["gender"].toString().toLowerCase() == Gender.female.name ? Gender.female : Gender.male;
    idNumber = json["IDNumber"].toString();
  }
}
