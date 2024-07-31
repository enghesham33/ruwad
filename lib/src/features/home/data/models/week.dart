// import 'package:rawdat_hufaz/src/features/home/data/models/quorum.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:intl/intl.dart';
import 'day.dart';
import 'weekly_task.dart';

class WeekModel {
  num? id;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  late double targetScore;
  late double userScore;
  String? quota;
  List<WeeklyTaskModel>? weeklyTask;
  List<DayModel>? days;
  // int? order;
  // List<QuorumModel>? quorum;

  WeekModel({
    required this.id,
    this.description = '',
    required this.startDate,
    required this.endDate,
    this.targetScore = 100,
    this.userScore = 0,
    this.quota = '',
    this.weeklyTask,
    this.days,
  });

  double get progress => userScore / targetScore;

  WeekModel.fromJson({required Map<String, dynamic> json}){
    id = json[ApiKeys.weekId] ?? 0;
    description = json[ApiKeys.description] ?? '';
    startDate = DateFormat("dd-MM-yyyy").parseStrict(json[ApiKeys.startDate]);
    endDate = DateFormat("dd-MM-yyyy").parseStrict(json[ApiKeys.endDate]);
    userScore = double.tryParse(json[ApiKeys.userScore].toString()) ?? 0;
    targetScore = double.tryParse(json[ApiKeys.targetScore].toString()) ?? 100;
    quota = json[ApiKeys.quota] ?? '';
    //weeklyTask = WeeklyTaskModel.fromJson(json: json[ApiKeys.weeklyTask]);
    weeklyTask = ( json[ApiKeys.weeklyTask] as List ).map((task) {
      return WeeklyTaskModel.fromJson(json: task);
    }).toList();

    days = ( json[ApiKeys.days] as List ).map((day) {
      final date = DateFormat("dd-MM-yyyy").parseStrict(day[ApiKeys.date]);
      return DayModel.fromJson(json: day, date: date);
    }).toList();
  }
  //
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