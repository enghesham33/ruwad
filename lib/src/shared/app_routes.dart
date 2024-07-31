import 'package:flutter/cupertino.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/screens/registration_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/call_request_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/main_call_page.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/request_list_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/call_screen.dart';
import 'package:rawdat_hufaz/src/features/exams/presentation/screens/exams_list_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/features/landing_page/presentation/landingpage.dart';
import 'package:rawdat_hufaz/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:rawdat_hufaz/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:rawdat_hufaz/src/features/wallet/presentation/screens/leader_board.dart';
import 'package:rawdat_hufaz/src/features/wallet/presentation/screens/wallet_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    RegistrationScreen.routeName: (context) => const RegistrationScreen(),
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    CallsScreen.routeName: (context) => const CallsScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
    SettingsScreen.routeName: (context) => const SettingsScreen(),
    ExamsListScreen.routeName: (context) => const ExamsListScreen(),
    MainCallPage.routeName: (context) => const MainCallPage(),
    CallRequestScreen.routeName: (context) => const CallRequestScreen(),
    RequestListScreen.routeName: (context) =>  const RequestListScreen(),
    LeaderboardScreen.routeName: (context) => LeaderboardScreen(),
    WalletScreen.routeName: (context) => const WalletScreen(),
    LandingPage.routeName: (context) => const LandingPage(),
    LeaderboardScreen.routeName: (context) => LeaderboardScreen(),
  };
}