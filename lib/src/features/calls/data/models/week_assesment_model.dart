import 'package:rawdat_hufaz/src/features/calls/data/models/mistake_model.dart';

class WeekAssesmentModel
{

  int evaluaterID;
  int weeklyTaskID;
  List<MistakeModel> mistakes;

    WeekAssesmentModel({
    required this.evaluaterID,
    required this.weeklyTaskID,
    required this.mistakes,
  });


  factory WeekAssesmentModel.fromJson(Map<String, dynamic> json) => WeekAssesmentModel(
        evaluaterID: json['evaluaterID'],
        weeklyTaskID: json['weeklyTaskID'],
        mistakes: List<MistakeModel>.from(json['mistakes'].map((x) => MistakeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'evaluaterID': evaluaterID,
        'weeklyTaskID': weeklyTaskID,
        'mistakes': List<dynamic>.from(mistakes.map((x) => x.toJson())),
      };
  
}