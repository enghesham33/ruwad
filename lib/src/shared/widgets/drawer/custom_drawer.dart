import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/main_call_page.dart';
import 'package:rawdat_hufaz/src/features/exams/presentation/screens/exams_list_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:rawdat_hufaz/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:rawdat_hufaz/src/features/wallet/presentation/screens/wallet_screen.dart';
import 'custom_drawer_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 8, bottom: 24, left: 8),
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(20),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDrawerItem(
                    icon: Icons.home_filled,
                    title: AppLocalizations.of(context)!.home,
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                    },
                  ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.person,
                    title: AppLocalizations.of(context)!.profile,
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.monetization_on,
                    title: AppLocalizations.of(context)!.wallet,
                    action: () 
                    {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(WalletScreen.routeName);
                    },
                  ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.call,
                    title: AppLocalizations.of(context)!.calls,
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(MainCallPage.routeName);
                    },
                  ),
                  // const Divider(),
                  // CustomDrawerItem(
                  //   icon: Icons.menu_book,
                  //   title: AppLocalizations.of(context)!.library,
                  //   action: () {},
                  // ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.quiz,
                    title: AppLocalizations.of(context)!.exams,
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ExamsListScreen.routeName);
                    },
                  ),
                  // const Divider(),
                  // CustomDrawerItem(
                  //   icon: Icons.gamepad,
                  //   title: AppLocalizations.of(context)!.challenges,
                  //   action: () {
                  //     Navigator.of(context).pop();
                  //     Navigator.of(context).pushNamed(ChallangeDicovery.routeName);
                  //   },
                  // ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.settings,
                    title: AppLocalizations.of(context)!.settings,
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}