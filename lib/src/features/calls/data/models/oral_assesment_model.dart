import 'package:rawdat_hufaz/src/features/calls/data/models/mistake_model.dart';

class OralAssesmentModel
{

  int evaluaterID;
  int personID;
  int examID;
  List<MistakeModel> mistakes;

    OralAssesmentModel({
    required this.evaluaterID,
    required this.personID,
    required this.examID,
    required this.mistakes,
  });


  factory OralAssesmentModel.fromJson(Map<String, dynamic> json) => OralAssesmentModel(
        evaluaterID: json['evaluaterID'],
        personID: json['personID'],
        examID: json['examID'],
        mistakes: List<MistakeModel>.from(json['mistakes'].map((x) => MistakeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'evaluaterID': evaluaterID,
        'personID': personID,
        'examID': examID,
        'mistakes': List<dynamic>.from(mistakes.map((x) => x.toJson())),
      };
  
}