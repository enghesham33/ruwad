import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_tag.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';
import '../../view_model/exams_view_model.dart';
import '../widgets/badges_widget.dart';
import '../widgets/exam_score_widget.dart';
import '../widgets/questions_count_widget.dart';
import '../widgets/score_ratio_widget.dart';
import 'exam_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExamDetailsScreen extends StatefulWidget {
  final int examID;

  const ExamDetailsScreen({
    super.key,
    required this.examID,
  });

  @override
  ExamDetailsScreenState createState() => ExamDetailsScreenState();
}

class ExamDetailsScreenState extends State<ExamDetailsScreen> {
  late final ExamsViewModel examsViewModel;

  @override
  void initState() {
    examsViewModel = Provider.of<ExamsViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
      () => examsViewModel.loadExamDetails(
        context: context,
        examId: widget.examID,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<ExamsViewModel>(
        builder: (context, watch, child) => watch.isLoadingExamDetails ||
                watch.exam == null
            ? SizedBox(
                height: 400.h,
                child: const Center(child: CustomLoadingIndicator()),
              )
            : SizedBox(
                height: size.height * 0.75,
                width: size.width,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.20,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                AppStyles.containerBigBorderRadius),
                            topRight: Radius.circular(
                                AppStyles.containerBigBorderRadius),
                            bottomLeft: Radius.circular(
                                AppStyles.containerBigBorderRadius),
                            bottomRight: Radius.circular(
                                AppStyles.containerBigBorderRadius),
                          ),
                          boxShadow: [AppStyles.containerBoxShadow]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text(
                              watch.exam!.name!,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTag(
                                  text: watch.exam!.type == null
                                      ? ''
                                      : watch.exam!.type!.title,
                                  backgroundColor:
                                      watch.exam!.type?.color ?? Palette.gray,
                                  foregroundColor: Palette.white,
                                  borderColor:
                                      watch.exam!.type?.color ?? Palette.gray,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTag(
                                  text: watch.exam!.status == null
                                      ? ''
                                      : watch.exam!.status!.titleAr,
                                  backgroundColor:
                                      watch.exam!.status?.color ?? Palette.gray,
                                  foregroundColor: Palette.white,
                                  borderColor:
                                      watch.exam!.status?.color ?? Palette.gray,
                                ),
                              ),
                            ],
                          ),
                          watch.showAttemptExamButton
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ExamScreen(
                                          examName: watch.exam!.name!,
                                          questions: watch.questions,
                                          onSubmitQuiz: watch.submitExam,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      //AppLocalizations.of(context)!.attempt_exam,
                                      "TODO- missed on merge ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, right: 16, left: 8, bottom: 8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppStyles
                                            .containerSmallBorderRadius),
                                      ),
                                      color: Theme.of(context).hoverColor
                                    ),
                                    child: ExamScoreContent(
                                      title: AppLocalizations.of(context)!.score,
                                      userScore: watch.exam!.userScore.toDouble(),
                                      targetScore: watch.exam!.targetScore.toDouble(),
                                    ),
                                  ),
                                ),
                                if (watch.exam!.questionsCount! > 0)
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 8,
                                          right: 16,
                                          left: 8,
                                          bottom: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(AppStyles
                                              .containerSmallBorderRadius),
                                        ),
                                        color: Theme.of(context).hoverColor,
                                      ),
                                      child: QuestionsCountContent(
                                        count: watch.exam!.questionsCount ?? 0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 16, right: 8, left: 16, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      AppStyles.containerSmallBorderRadius),
                                ),
                                color: Theme.of(context).hoverColor,
                              ),
                              child: ScoreRatioContent(
                                ratio: watch.exam!.rankPercent!,
                                // ratio: watch.exam!.,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 8, right: 16, left: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                AppStyles.containerSmallBorderRadius),
                          ),
                          color: Theme.of(context).hoverColor,
                        ),
                        child: BadgesWidget(
                          exam: watch.exam!,
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
