import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/widgets/call_request_button.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/test_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/widgets/custom_weekly_task_score_container.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/weekly_task_view_model.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_no_data_widget.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_progress_bar.dart';

class WeeklyTaskScreen extends StatefulWidget {
  const WeeklyTaskScreen({super.key, required this.weekID});

  final num? weekID;

  @override
  State<WeeklyTaskScreen> createState() => _WeeklyTaskScreenState();
}

class _WeeklyTaskScreenState extends State<WeeklyTaskScreen> {
  late final WeeklyTaskViewModel weeklyTaskViewModel;
  late final TestViewModel testViewModel;


  @override
  void initState() {
    weeklyTaskViewModel =
    Provider.of<WeeklyTaskViewModel>(context, listen: false);
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      weeklyTaskViewModel.loadWeeklyTaskData(
        context: context,
        weekID: widget.weekID,
      );
      testViewModel.loadTestResults();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox spacer = SizedBox(height: 16.h);
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Consumer<WeeklyTaskViewModel>(
          builder: (context, watch, _) => watch.isLoading
              ? SizedBox(
                  height: size.height * 0.8,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : widget.weekID == null || watch.weeklyTask == null
                  ? SizedBox(
                      height: size.height * 0.8,
                      child: CustomNoDataWidget(
                        text:
                            AppLocalizations.of(context)!.message_no_data_title,
                        subText: AppLocalizations.of(context)!
                            .message_no_weekly_task,
                        displayImage: true,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spacer,
                        Text(
                          AppLocalizations.of(context)!.weekly_task_title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        spacer,
                        spacer,
                        CustomBigContainer(
                          size: size,
                          color: watch.weeklyTask!.progress == 1
                              ? context.read<SettingsViewModel>().isDarkMode()
                                  ? Palette.darkOlive
                                  : Palette.lightPrimaryColor
                              : context.read<SettingsViewModel>().isDarkMode()
                                  ? Palette.primaryColor
                                  : Palette.lightPrimaryColor,
                          title: watch.weeklyTask!.description!,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                 
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.score,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: CustomProgressBar(
                                        size: size,
                                        value: watch.weeklyTask!.progress,
                                        showValues: true,
                                        isPercentage: false,
                                        outOf: watch.weeklyTask!.targetScore,
                                      ),
                                    ),
                                  ],
                                ),
                                spacer,
                              ],
                            ),
                          ),
                        ),
                        spacer,
                        spacer,
                        watch.weeklyTask!.isDone!
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.score,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        CustomDialog(context).showInstructions(
                                      title: AppLocalizations.of(context)!
                                          .message_title_mistakes,
                                      instructions:
                                          "${AppLocalizations.of(context)!.message_instruction_memorization_mistake}\n"
                                          "\n${AppLocalizations.of(context)!.message_instruction_missSpelling_mistake}",
                                    ),
                                    icon: const Icon(
                                      Icons.info_outline,
                                      color: Palette.accentColor,
                                    ),
                                    iconSize: 16,
                                  ),
                                ],
                              )
                            : spacer,
                        // spacer,
                         watch.weeklyTask!.isDone!
                        ?
                        CustomWeeklyTaskScoreContainer(
                            size: size,
                            test: testViewModel.test!,
                            weeklyTask: watch.weeklyTask!)
                         :
                         
                         CallRequestButton(examId: watch.weeklyTask?.id, quorum: watch.weeklyTask!.description??"", isOralAssesment: false,)
                         
                      ],
                    ),
        ),
      ),
    );
  }
}
