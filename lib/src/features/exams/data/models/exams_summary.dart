class ExamsSummaryModel {
  num levelExamsUserScore;
  num levelExamsTargetScore;
  num cumulativeExamsUserScore;
  num cumulativeExamsTargetScore;
  num tasksUserScore;
  num tasksTargetScore;

  ExamsSummaryModel({
    required this.levelExamsUserScore,
    required this.levelExamsTargetScore,
    required this.cumulativeExamsUserScore,
    required this.cumulativeExamsTargetScore,
    required this.tasksUserScore,
    required this.tasksTargetScore,
  });

  factory ExamsSummaryModel.fromJson(Map<String, dynamic> json) {
    return ExamsSummaryModel(
      levelExamsUserScore: json['levelExamsUserScore'] ?? 0.0,
      levelExamsTargetScore: json['levelExamsTargetScore'] ?? 0.0,
      cumulativeExamsUserScore: json['cumulativeExamsUserScore'] ?? 0.0,
      cumulativeExamsTargetScore: json['cumulativeExamsTargetScore'] ?? 0.0,
      tasksUserScore: json['tasksUserScore'] ?? 0.0,
      tasksTargetScore: json['tasksTargetScore'] ?? 0.0,
    );
  }

  double get levelScoreRatio =>  _calculatePercentage(levelExamsUserScore, levelExamsTargetScore);
  double get cumulativeScoreRatio =>  _calculatePercentage(cumulativeExamsUserScore, cumulativeExamsTargetScore);
  double get tasksScoreRatio =>  _calculatePercentage(tasksUserScore, tasksTargetScore);


  double _calculatePercentage(num studentScore, num targetScore) {
    if (targetScore == 0) {
      return 0.0;
    }
    double percentage = (studentScore / targetScore) * 100.0;
    return percentage.clamp(0.0, 100.0);
  }
}