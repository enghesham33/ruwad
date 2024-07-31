import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';

class TaskModel {
  int? id;
  int? sequence;
  String? type;
  String? helpText;
  bool? isOptional;
  late int userRepetitions;
  late int maxRepetitions;

  TaskModel({
    required this.id,
    required this.sequence,
    required this.type,
    this.helpText = "",
    this.isOptional = false,
    this.userRepetitions = 0,
    this.maxRepetitions = 1,
  });

  double get progress => userRepetitions / maxRepetitions;

  TaskModel.fromJson({required Map<String, dynamic> json}){
    id = json["taskId"] ?? 0;
    sequence = json[ApiKeys.sequence] ?? 0;
    type = json[ApiKeys.taskType] ?? '';
    helpText = json[ApiKeys.helpText] ?? "";
    isOptional = json[ApiKeys.isOptional] ?? true;
    userRepetitions = json[ApiKeys.repetitions] ?? 0;
    maxRepetitions = json[ApiKeys.maxRepetitions] ?? 1;
  }
}