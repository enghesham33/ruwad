import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/custom_week_tab.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/tasks_record_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import '../../../../shared/widgets/custom_no_data_widget.dart';

class TaskRecordsScreen extends StatefulWidget {
  const TaskRecordsScreen({super.key});

  @override
  State<TaskRecordsScreen> createState() => _TaskRecordsScreenState();
}

class _TaskRecordsScreenState extends State<TaskRecordsScreen> {
  late final TasksRecordViewModel tasksRecordViewModel;

  @override
  void initState() {
    tasksRecordViewModel =
        Provider.of<TasksRecordViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
      () => tasksRecordViewModel.loadTasksRecord(context: context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<TasksRecordViewModel>(
        builder: (context, tasksRecordsProvider, child) => tasksRecordsProvider.isLoading
            ? SizedBox(
                height: size.height * 0.8,
                child: const Center(child: CircularProgressIndicator()),
              )
            : tasksRecordsProvider.weeks.isEmpty
                ? SizedBox(
                    height: size.height * 0.8,
                    child: CustomNoDataWidget(
                      text: AppLocalizations.of(context)!.message_no_data_title,
                      subText: AppLocalizations.of(context)!.message_no_tasks,
                      displayImage: true,
                    ),
                  )
                : DefaultTabController(
                    length: tasksRecordsProvider.weeks.length,
                    initialIndex: tasksRecordsProvider.initialTabIndex(),
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        backgroundColor: Theme.of(context).canvasColor,
                        elevation: 0.5,
                        toolbarHeight: 0,
                        bottom: TabBar(
                          indicatorColor: Palette.accentColor,
                          unselectedLabelColor:
                              Palette.accentColor.withOpacity(0.5),
                          labelColor: Palette.accentColor,
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          indicatorWeight: 3,
                          tabs: tasksRecordsProvider.weeks
                              .map((element) => Tab(text: element.description!))
                              .toList(),
                          isScrollable: true,
                        ),
                      ),
                      body: TabBarView(
                        children: tasksRecordsProvider.weeks
                            .map((week) => CustomWeekTab(
                                  week: week,
                                  // weeklyTask: weeklyTaskProvider.weeklyTask!,
                                  days: week.days!,
                                  size: size,
                                ))
                            .toList(),
                      ),
                    ),
                  ));
  }
}
