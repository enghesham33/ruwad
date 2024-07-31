import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/home/data/models/week.dart';

enum MistakeType{
  memorization(worth: 2),
  missSpelling(worth: 1);

  final int worth;

  const MistakeType({this.worth = 1});

  String type (BuildContext ctx){
    if (name == "memorization"){
      return AppLocalizations.of(ctx)!.memorization_mistake;
    } else if (name == "missSpelling"){
      return AppLocalizations.of(ctx)!.missSpelling_mistake;
    } else {
      return name;
    }
  }
}

class TestModel{
  List<MistakeType> mistakes;

  TestModel({required this.mistakes,});

  double get calaculateScore{
    double score = 100;
    for(int i=0; i<mistakes.length; i++){
      score -= mistakes[i].worth;
    }
    return score;
  }

  void setWeeklyTaskScore(WeekModel week){
    week.userScore = (week.targetScore * calaculateScore) / 100;
  }
}