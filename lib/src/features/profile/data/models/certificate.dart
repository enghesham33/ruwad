class CertificateModel {
  List<SectionModel>? sections;

  CertificateModel({
    this.sections,
  });

  CertificateModel.fromJson({required Map<String, dynamic> json}) {
    sections = (json["sections"] as List)
        .map((sectionDate) => SectionModel.fromJson(json: sectionDate))
        .toList();
  }
}

class SectionModel {
  String? name;
  double? tasksScore;
  double? examsScore;
  double? totalScore;
  double? targetTasksScore;
  double? targetExamsScore;
  double? targetTotalScore;

  SectionModel({
    this.name,
    this.examsScore,
    this.tasksScore,
    this.totalScore,
    this.targetTasksScore,
    this.targetExamsScore,
    this.targetTotalScore,
  });

  SectionModel.fromJson({required Map<String, dynamic> json}) {
    name = json["name"] ?? '';
    tasksScore = (json["tasksScore"]).toDouble() ?? 0.0;
    examsScore = (json["examsScore"]).toDouble() ?? 0.0;
    totalScore = (json["totalScore"]).toDouble() ?? 0.0;
    targetTasksScore = (json["targetTasksScore"]).toDouble() ?? 30;
    targetExamsScore = (json["targetExamsScore"]).toDouble() ?? 70;
    targetTotalScore = (json["targetTotalScore"]).toDouble() ?? 100;
  }
}
