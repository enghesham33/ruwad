import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/test.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/widgets/custom_mistake_row.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';

import '../../data/models/weekly_task.dart';

class CustomWeeklyTaskScoreContainer extends StatelessWidget {
  const CustomWeeklyTaskScoreContainer({super.key, required this.weeklyTask, required this.test, required this.size});

  final TestModel test ;
  final WeeklyTaskModel weeklyTask;
  final Size size;

  List<Map<String, Object>> _groupedMistakesDeductions(BuildContext ctx) {
    return List.generate(2, (index) {
      final String type = MistakeType.values[index].type(ctx);
      int deductions = 0;
      for (MistakeType mistake in test.mistakes) {
        if (mistake.type(ctx) == type) {
          deductions += mistake.worth;
        }
      }

      return {'type': type, "deductions" : deductions };
    }).reversed.toList();
  }

  List<Map<String, Object>> _groupedMistakesCounts(BuildContext ctx){
    return List.generate(2, (index) {
      final String type = MistakeType.values[index].type(ctx);
      int count = 0;
      for (MistakeType mistake in test.mistakes) {
        if (mistake.type(ctx) == type) {
          count++;
        }
      }

      return {'type': type, "count" : count };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, Object>> deductions = _groupedMistakesDeductions(context);
    final List<Map<String, Object>> counts = _groupedMistakesCounts(context);

    return CustomBigContainer(
      size: size,
      color: context.read<SettingsViewModel>().isDarkMode() ? Palette.darkOlive : Palette.lightOlive,
      // title: AppLocalizations.of(context)!.score,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomMistakeRow(
              type: deductions[0]["type"] as String,
              deduction: deductions[0]["deductions"] as int,
              count: counts[0]["count"] as int,
            ),
            const SizedBox(height: 16,),
            CustomMistakeRow(
              type: deductions[1]["type"] as String,
              deduction: deductions[1]["deductions"] as int,
              count: counts[1]["count"] as int,
            ),
          ]
          // groupedMistakesDeductions.map((element) => CustomMistakeRow(
          //   type: element["type"] as String,
          //   deduction: element["deductions"] as int,
          //   count: element["count"] as int,
          // )).toList(),
        ),
      ),
    );
  }
}