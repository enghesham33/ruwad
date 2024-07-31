import 'package:get_it/get_it.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/data_sources/registration_local_data_source.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/data_sources/registration_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/repositories/authentication_repository.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/repositories/registration_repository.dart';
import 'package:rawdat_hufaz/src/features/calls/data/data_sources/assesment_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/calls/data/data_sources/quraan_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/calls/data/data_sources/supabase_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/assesment_repository.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/quraan_repository.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/supabase_repository.dart';
import 'package:rawdat_hufaz/src/features/exams/data/data_sources/exam_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/exams/data/repositories/exams_repository.dart';
import 'package:rawdat_hufaz/src/features/home/data/data_sources/daily_tasks_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/home/data/data_sources/home_local_data_source.dart';
import 'package:rawdat_hufaz/src/features/home/data/data_sources/tasks_record_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/home/data/data_sources/weekly_task_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/home/data/repositories/daily_tasks_repository.dart';
import 'package:rawdat_hufaz/src/features/home/data/repositories/home_repository.dart';
import 'package:rawdat_hufaz/src/features/home/data/repositories/tasks_record_repository.dart';
import 'package:rawdat_hufaz/src/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/profile/data/repositories/profile_repository.dart';
import 'package:rawdat_hufaz/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:rawdat_hufaz/src/features/settings/data/repositories/settings_local_repository.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/repositories/wallet_repository.dart';
import '../../features/home/data/repositories/weekly_task_repository.dart';
import '../connectivity_checker.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  getItInstance.registerLazySingleton<SettingsLocalRepository>(() =>
      SettingsLocalRepository(
        localDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepository(
        localDataSource: getItInstance(),
        remoteDataSource:  getItInstance(),
        connectivity:  getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<RegistrationRepository>(() =>
      RegistrationRepository(
        localDataSource: getItInstance(),
        remoteDataSource:  getItInstance(),
        connectivity:  getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<HomeRepository>(() =>
      HomeRepository(
        localDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<DailyTasksRepository>(() =>
      DailyTasksRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<TasksRecordRepository>(() =>
      TasksRecordRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<ExamsRepository>(() =>
      ExamsRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<WeeklyTaskRepository>(() =>
      WeeklyTaskRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

  getItInstance.registerLazySingleton<WalletRepository>(() =>
      WalletRepository(
        connectivity: getItInstance(),
        remoteDataSource: getItInstance(),
      ),
  );

   getItInstance.registerLazySingleton<SupabaseRepository>(() =>
       SupabaseRepository(
         connectivity: getItInstance(),
         remoteDataSource: getItInstance(),
       ),
   );

    getItInstance.registerLazySingleton<QuraanRepository>(() =>
    QuraanRepository(
      connectivity: getItInstance(),
      remoteDataSource: getItInstance(),
    ),
   );

   getItInstance.registerLazySingleton<AssesmentRepository>(() =>
    AssesmentRepository(
      connectivity: getItInstance(),
      remoteDataSource: getItInstance(),
    ),
   );

  //------------------------ data sources------------------------//
  getItInstance.registerLazySingleton<ConnectivityChecker>(
        () => ConnectivityChecker(),
  );

  getItInstance.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSource(),
  );

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
        () => AuthenticationLocalDataSource(),
  );

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<RegistrationRemoteDataSource>(
        () => RegistrationRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<RegistrationLocalDataSource>(
        () => RegistrationLocalDataSource(),
  );

  getItInstance.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSource(),
  );

  getItInstance.registerLazySingleton<DailyTasksRemoteDataSource>(
        () => DailyTasksRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<TasksRecordRemoteDataSource>(
        () => TasksRecordRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<ExamRemoteDataSource>(
        () => ExamRemoteDataSource(),
  );

  getItInstance.registerLazySingleton<WeeklyTaskRemoteDataSource>(
        () => WeeklyTaskRemoteDataSource(),
  );
    getItInstance.registerLazySingleton<SupabaseRemoteDataSource>(
        () => SupabaseRemoteDataSource(),
  );
  getItInstance.registerLazySingleton<QuraanRemoteDataSource>(
        () => QuraanRemoteDataSource(),
  );
  getItInstance.registerLazySingleton<AssesmentRemoteDataSource>(
        () => AssesmentRemoteDataSource(),
  );
  getItInstance.registerLazySingleton<WalletRemoteDataSource>(
        () => WalletRemoteDataSource(),
  );


}
