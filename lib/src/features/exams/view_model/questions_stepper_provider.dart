import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/question.dart';

class QuestionsStepperProvider extends ChangeNotifier{

  int _index = 0;
  static List<QuestionModel>? _questions;

  List<QuestionModel>? get questions => _questions ?? [];
  int get index => _index;
  int get questionsCount => questions!.length;

  back(context) {
    FocusScope.of(context).unfocus();
    _index -= 1;
    notifyListeners();
  }

  next(context) {
    FocusScope.of(context).unfocus();
    _index += 1;
    notifyListeners();
  }

  goToStep(int index, context) {
    FocusScope.of(context).unfocus();
      _index = index;
      notifyListeners();
  }

  setQuestions(List<QuestionModel> questions){
    _questions = questions;
    print("HI LOLO: INDEX IS ---> $_index");
    _index = 0;
    notifyListeners();
  }

  answerQuestion({ required String answer }){
    _questions![_index].userAnswer = answer;
    _questions![_index].isAnswered = true;
    notifyListeners();
  }

}

