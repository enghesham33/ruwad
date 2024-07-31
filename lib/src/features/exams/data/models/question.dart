import 'types/question_type.dart';

class QuestionModel{
  String? text;
  late int questionID;
  late QuestionType? type;
  bool? isAnswered ;
  bool? isCorrect;
  late double userScore;
  late double targetScore;
  late String userAnswer;
  String? correctAnswer;
  List<String>? answers;

  QuestionModel({
    this.text = "",
    required this.questionID,
    required this.type,
    this.isAnswered,
    this.isCorrect,
    this.userScore = 0,
    this.targetScore = 0,
    this.userAnswer = "",
    this.correctAnswer = "",
    this.answers,
  });

  QuestionModel.fromJson({required Map<String, dynamic> json}){
    text = json["text"] ?? "";
    questionID = json["questionID"];
    type = QuestionType.map(json["questionType"]);
    isAnswered = json["isAnswred"];
    isCorrect = json["isCorrect"];
    userScore = double.tryParse(json["userScore"].toString()) ?? 0;
    targetScore = double.tryParse(json["targetScore"].toString()) ?? 0;
    userAnswer = json["userAnswer"] ?? "";
    correctAnswer = json["correctAnswer"] ?? "";
    answers = json["answers"] == null ? [] : [...json["answers"]];
  }

  Map<String, dynamic> toJson() => {
    "questionID": questionID,
    "userAnswer": userAnswer,
  };
}
