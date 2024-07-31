import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/widgets/custom_day_date_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_progress_bar.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_no_data_widget.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';
import '../../view_model/daily_tasks_view_model.dart';
import '../widgets/custom_task_row.dart';
import '../widgets/custom_task_title_container.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key, required this.date});

  final DateTime date;

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  late final DailyTasksViewModel dailTasksViewModel;

  @override
  void initState() {
    dailTasksViewModel =
        Provider.of<DailyTasksViewModel>(context, listen: false);
    Future.delayed(
        Duration.zero,
        () => dailTasksViewModel.loadDayData(
            context: context, date: widget.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox spacer = SizedBox(height: 24.h);
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Consumer<DailyTasksViewModel>(
          builder: (context, watch, child) => watch.isLoading
              ? SizedBox(
                  height: size.height * 0.8,
                  child: const Center(child: CustomLoadingIndicator()),
                )
              : watch.tasks.isEmpty
                  ? SizedBox(
                      height: size.height * 0.8,
                      child: CustomNoDataWidget(
                        text:
                            AppLocalizations.of(context)!.message_no_data_title,
                        subText: AppLocalizations.of(context)!.message_no_tasks,
                        displayImage: true,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        spacer,
                        CustomDayDateRow(date: watch.day.date),
                        spacer,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.progress,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: CustomProgressBar(
                                  size: size,
                                  value: watch.day.progress,
                                  isPercentage: true,
                                  showValues: true,
                                  outOf: watch.day.targetScore,
                                ),
                              ),
                            ],
                          ),
                        ),
                        spacer,
                        Stack(
                          children: <Widget>[
                            Positioned(
                              child: CustomBigContainer(
                                color: context
                                        .read<SettingsViewModel>()
                                        .isDarkMode()
                                    ? Palette.primaryColor
                                    : Palette.lightPrimaryColor,
                                size: size,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 80, bottom: 8),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .daily_tasks,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ),
                                      ...watch.tasks.map((element) {
                                        return CustomTaskRow(
                                          task: element,
                                          progress: element.progress,
                                          increment: () => watch.incrementScore(
                                              context: context,
                                              taskID: element.id!),
                                          // onChanged: (score) => watch.setTaskScore(
                                          //     taskID: element.id!,
                                          //     score: score,
                                          // ),
                                          submitScore: (score) =>
                                              watch.submitTaskScore(
                                            context: context,
                                            taskID: element.id!,
                                            score: score,
                                          ),
                                          reset: () => watch.resetTask(
                                              context: context,
                                              taskID: element.id!),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 16,
                                      )
                                    ]),
                              ),
                            ),
                            Positioned(
                              child: CustomTasksTitleContainer(
                                size: size,
                                quorum: watch.day.quota!,
                              ),
                            ),
                          ],
                        ),
                        spacer,
                      ],
                    ),
        ),
      ),
    );
  }
}
