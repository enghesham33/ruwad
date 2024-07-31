import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/registration_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/quraan_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/test_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/timer_view_model.dart';
import 'package:rawdat_hufaz/src/features/exams/view_model/exams_view_model.dart';
import 'package:rawdat_hufaz/src/features/exams/view_model/questions_stepper_provider.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/daily_tasks_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/tasks_record_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/weekly_task_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/view_model/points_view_model.dart';
import 'package:rawdat_hufaz/src/features/profile/view_model/levels_view_model.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/view_model/wallet_view_model.dart';
import 'package:rawdat_hufaz/src/rawdat_alhufaz_app.dart';
import './src/shared/di/get_di.dart' as di;
import 'src/features/profile/view_model/profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await SettingsViewModel.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => SettingsViewModel()),
              ChangeNotifierProvider(create: (context) => AuthenticationViewModel(),),
              ChangeNotifierProvider(create: (context) => RegistrationViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => HomeViewModel()),
              ChangeNotifierProvider(create: (context) => DailyTasksViewModel()),
              ChangeNotifierProvider(create: (context) => TasksRecordViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => WeeklyTaskViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => TestViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => ExamsViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => QuestionsStepperProvider(), lazy: true),
              ChangeNotifierProvider(create: (context) => ProfileViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => LevelsViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => CallRequestViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => QuranProvider(), lazy: true),
              ChangeNotifierProvider(create: (context) => TimerViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => WalletViewModel(), lazy: true),
              ChangeNotifierProvider(create: (context) => PointsViewModel(), lazy: true),

            ],
            child: const RawdatAlhufazApp(),
          ),
  ));
}
