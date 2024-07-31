import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class DayModel {
  DateTime date;
  late double userScore;
  late double targetScore;
  String? quota;
  // final String id;
  // final List<QuorumModel> quorum;

  DayModel.fromJson({
    required this.date,
    required Map<String, dynamic> json,
    // this.userScore = 0,
    // this.targetScore = 100,
    // this.quota = '',
    // required this.id,
    // required this.quorum,
  }){
    date = date;
    userScore = double.tryParse(json[ApiKeys.userScore].toString()) ?? 0;
    targetScore = double.tryParse(json[ApiKeys.targetScore].toString()) ?? 100;
    quota = json[ApiKeys.quota] ?? "";
  }

  double get progress => userScore / targetScore;

  // String get printQuorum {
  //   String result = "";
  //   for ( int i = 0; i < quorum.length; i++){
  //     if (i == (quorum.length-1) ){
  //       result += quorum[i].toString();
  //     } else {
  //       result += "${quorum[i].toString()}, ";
  //     }
  //   }
  //   return result;
  // }
}