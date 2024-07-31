import 'types/exam_status.dart';
import 'types/exam_type.dart';

class ExamModel {
  int? id;
  String? name;
  int? questionsCount;
  late num userScore;
  late num targetScore;
  bool? isActive;
  bool? isDone;
  bool? isGraded;
  bool? isHighest;
  double? rankPercent;
  ExamType? type;
  ExamStatus? status;

  ExamModel({
    required this.id,
    this.name,
    this.questionsCount = 0,
    this.userScore = 0,
    this.targetScore = 100,
    this.isActive = false,
    this.isDone = false,
    this.isGraded = false,
    this.isHighest = false,
    this.rankPercent = 0,
    required this.type,
    required this.status,
  });

  ExamModel.fromJson({
    required Map<String, dynamic> json,
    int? examID,
  }) {
    id = examID ?? json["examID"] ?? 0;
    name = json["name"] ?? "";
    questionsCount = json["questionsCount"] ?? 0;
    userScore = double.tryParse(json["userScore"].toString()) ?? 0;
    targetScore = double.tryParse(json["targetScore"].toString()) ?? 100;
    isActive = json["isActive"] ?? false;
    isDone = json["isDone"] ?? false;
    isGraded = json["isGraded"] ?? false;
    isHighest = json["highest"] ?? false;
    rankPercent = double.tryParse(json["rankPercent"].toString()) ?? 0;
    type = ExamType.map(json['type'].toString());
    status = ExamStatus.map(json['status'].toString());
  }
}




