import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/daily_tasks_screen.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/tasks_record_view_model.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_small_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_progress_bar.dart';

import '../../data/models/day.dart';
import 'custom_day_date_row.dart';

class CustomDayContainer extends StatelessWidget {
  const CustomDayContainer({super.key, required this.day, required this.size});

  final DayModel day;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomSmallContainer(
        size: size,
        onTap: () async {
          await showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              isScrollControlled: true,
              isDismissible: true,
              builder: (BuildContext context) {
                return SizedBox(
                  height: size.height * 0.75,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, left: 8, top: 24),
                    child: DailyTasksScreen(date: day.date),
                  ),
                );
              });
          context
              .read<TasksRecordViewModel>()
              .setTab(DefaultTabController.of(context).index);
          await context
              .read<TasksRecordViewModel>()
              .loadTasksRecord(context: context);
        },
        color: day.progress == 1
            ? Palette.lightAccentColor.withOpacity(0.5)
            : context.read<SettingsViewModel>().isDarkMode()
                ? Palette.primaryColor
                : Palette.lightPrimaryColor,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            CustomDayDateRow(
              date: day.date,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  day.quota!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // dailyTasksController.obx((state) =>
            CustomProgressBar(
              size: size,
              value: day.progress,
              showValues: false,
              outOf: day.targetScore,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${day.userScore.toStringAsFixed(0)}%",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
