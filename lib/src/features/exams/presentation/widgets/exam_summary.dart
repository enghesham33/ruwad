import 'package:activity_ring/activity_ring.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/exams_summary.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';

import 'exam_score_widget.dart';

class ExamSummary extends StatelessWidget {
  const ExamSummary(
      {super.key,
      required this.size,
      required this.summaryData,
      });

  final ExamsSummaryModel summaryData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CustomBigContainer(
      color: Theme.of(context).cardColor,
      size: size,
      child: SizedBox(
        height: 300,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExamScoreContent(
                        title: AppLocalizations.of(context)!.tasks_result,
                        userScore: summaryData.tasksUserScore.ceilToDouble(),
                        targetScore: summaryData.tasksTargetScore.ceilToDouble(),
                        color: context.read<SettingsViewModel>().isDarkMode()
                            ? Palette.lightOlive
                            : Palette.darkOlive,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      ExamScoreContent(
                        title: AppLocalizations.of(context)!.exams,
                        userScore: summaryData.levelExamsUserScore.ceilToDouble(),
                        targetScore: summaryData.levelExamsTargetScore.ceilToDouble(),
                        color: context.read<SettingsViewModel>().isDarkMode()
                            ? Palette.lightPrimaryColor
                            : Palette.primaryColor,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      ExamScoreContent(
                        title: AppLocalizations.of(context)!.cumulative_result,
                        userScore: summaryData.cumulativeExamsUserScore.ceilToDouble(),
                        targetScore: summaryData.cumulativeExamsTargetScore.ceilToDouble(),
                        color: context.read<SettingsViewModel>().isDarkMode()
                            ? Palette.orange
                            : Palette.red,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ring(
                          percent: summaryData.cumulativeScoreRatio,
                          color: RingColorScheme(
                              ringColor:
                              context.read<SettingsViewModel>().isDarkMode()
                                  ? Palette.orange
                                  : Palette.red,
                              backgroundColor: Theme.of(context).splashColor,
                          ),
                          radius: 40,
                          width: 17,
                        ),
                        Ring(
                          percent: summaryData.levelScoreRatio,
                          color: RingColorScheme(
                              ringColor:
                              context.read<SettingsViewModel>().isDarkMode()
                                  ? Palette.lightPrimaryColor
                                  : Palette.primaryColor,
                              backgroundColor: Theme.of(context).splashColor,
                          ),
                          radius: 60,
                          width: 17,
                        ),
                        Ring(
                          percent: summaryData.tasksScoreRatio,
                          color: RingColorScheme(
                              ringColor: context.read<SettingsViewModel>().isDarkMode()
                                  ? Palette.lightOlive
                                  : Palette.darkOlive,
                              backgroundColor: Theme.of(context).splashColor,
                          ),
                          radius: 80,
                          width: 17,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
