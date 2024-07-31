import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class WeeklyTaskModel {
  int? id;
  String? description;
  late double targetScore;
  late double userScore;
  bool? isDone;

  WeeklyTaskModel({
    required this.id,
    this.description = '',
    this.targetScore = 100,
    this.userScore = 0,
    this.isDone = false,
  });

  double get progress => userScore / targetScore;

  WeeklyTaskModel.fromJson({required Map<String, dynamic> json}){
    id = json[ApiKeys.weeklyTaskID] ?? 0;
    description = json[ApiKeys.description] ?? '';
    userScore = double.tryParse(json[ApiKeys.userScore].toString()) ?? 0;
    targetScore = double.tryParse(json[ApiKeys.targetScore].toString()) ?? 100;
    isDone = json[ApiKeys.isDone] ==false? false:true;
  }
}
