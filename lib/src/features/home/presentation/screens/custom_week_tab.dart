import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/widgets/custom_day_container.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_progress_bar.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';
import '../../data/models/day.dart';
import '../../data/models/week.dart';
import '../../view_model/weekly_task_view_model.dart';
import '../widgets/custom_week_dates_rows.dart';
import 'weekly_task_screen.dart';

class CustomWeekTab extends StatefulWidget {
  const CustomWeekTab({
    super.key,
    required this.week,
    required this.days,
    required this.size,
  });

  final WeekModel week;
  final List<DayModel> days;
  final Size size;

  @override
  State<CustomWeekTab> createState() => _CustomWeekTabState();
}

class _CustomWeekTabState extends State<CustomWeekTab> {
  late final WeeklyTaskViewModel weeklyTaskViewModel;

  @override
  void initState() {
    weeklyTaskViewModel =
        Provider.of<WeeklyTaskViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
      () => weeklyTaskViewModel.loadWeeklyTaskData(
          context: context, weekID: widget.week.id!),
    );
    super.initState();
  }

  _showWeeklyTaskDetails(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            height: widget.size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 16),
              child: WeeklyTaskScreen(weekID: widget.week.id!),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    const SizedBox spacer = SizedBox(
      height: 24,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //spacer,
          Container(            
            decoration: BoxDecoration
            (
              color: Palette.containerBorderColor.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:20.0,bottom: 20),
              child: CustomWeekDateRows(
                  startDate: widget.week.startDate!, endDate: widget.week.endDate!
                  ),
            ),
          ),
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
                    size: widget.size,
                    value: widget.week.progress,
                    isPercentage: true,
                    showValues: true,
                  ),
                ),
              ],
            ),
          ),
          spacer,
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 25),
            child: Text(AppLocalizations.of(context)!.weekly_task_title,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer<WeeklyTaskViewModel>(
              builder: (context, watch, _) => watch.isLoading ||
                      watch.weeklyTask == null
                  ? SizedBox(
                      height: 40.h,
                      child: const Center(child: CustomLoadingIndicator()),
                    ): watch.weeklyTask!.id==0?
                    Container()
                  : CustomBigContainer(
                      size: widget.size,
                      onTap: () => _showWeeklyTaskDetails(context),
                      color: watch.weeklyTask!.progress == 1
                          ? context.read<SettingsViewModel>().isDarkMode()
                              ? Palette.darkOlive
                              : Palette.lightOlive
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
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                  child: CustomProgressBar(
                                    size: widget.size,
                                    value: watch.weeklyTask!.progress,
                                    showValues: true,
                                    isPercentage: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          spacer,
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 25),
            child: Text(AppLocalizations.of(context)!.daily_tasks_tab,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(
            height: 197,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.days.length,
              itemBuilder: (context, index) {
                return CustomDayContainer(
                    day: widget.days[index], size: widget.size);
              },
            ),
          ),
          spacer,
          spacer,
        ],
      ),
    );
  }
}
