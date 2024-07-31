import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/daily_tasks_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/task_records_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/weekly_task_screen.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import '../../../../shared/widgets/drawer/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () => homeViewModel.loadHomeData(context: context) );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.5,
            title: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Consumer<HomeViewModel>(
                builder: (context, watch, child) => Text(
                  watch.currentLevel?.name ?? AppLocalizations.of(context)!.rawdat_alhufaz,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: FittedBox(
                      child: Text(
                    AppLocalizations.of(context)!.tasks_record_tab,
                    textAlign: TextAlign.center,
                  )),
                ),
                Tab(
                  child: FittedBox(
                      child: Text(
                    AppLocalizations.of(context)!.daily_tasks_tab,
                    textAlign: TextAlign.center,
                  )),
                ),
                Tab(
                  child: FittedBox(
                      child: Text(
                    AppLocalizations.of(context)!.weekly_task_tab,
                    textAlign: TextAlign.center,
                  )),
                ),
              ],
              indicatorWeight: 3,
              indicatorColor: Palette.lightAccentColor,
              unselectedLabelColor: Palette.lightAccentColor.withOpacity(0.5),
              labelColor: Palette.lightAccentColor,
              labelStyle: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          body: Consumer<HomeViewModel>(
            builder: (context, watch, child) => TabBarView(
              children: <Widget>[
                const TaskRecordsScreen(),
                DailyTasksScreen(date: DateTime.now()),
                WeeklyTaskScreen(weekID: watch.currentWeekID,)
              ],
            ),
          ),
        ),
    );
  }
}
