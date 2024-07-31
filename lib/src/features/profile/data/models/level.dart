import 'package:rawdat_hufaz/src/shared/enums.dart';

class LevelModel {
  String? id;
  String? name;
  LevelStatus? status;
  // final int order;
  // List<String>? surahs;
  String? quota;
  String? description;

  LevelModel({
    this.id,
    this.name,
    this.status,
    // this.order = ,
    // this.surahs,
    this.quota,
    this.description = "",
  });

  LevelModel.fromJson({required Map<String, dynamic> json}) {
    id = json["levelID"].toString() ;
    name = json["LevelName"];
    description = json['CurrentlevelName'] ?? json["name"];
    quota = json['QuotaName'] ?? '';
    status = json['status'] == "active" ? LevelStatus.active : LevelStatus.ended ;
  }

  // String get printSurahs {
  //   String result = "";
  //   if (surahs == null){
  //     return result;
  //   }
  //   for ( int i = 0; i < surahs!.length; i++){
  //     if (i == (surahs!.length-1) ){
  //       result += surahs![i].toString();
  //     } else {
  //       result += "${surahs![i].toString()} - ";
  //     }
  //   }
  //   return result;
  // }
}
