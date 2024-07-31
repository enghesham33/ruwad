import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';

import '../../../../shared/themes/palette.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static String routeName = "Settings";

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, watch, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.settings,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      leading: watch.isDarkMode()
                          ? const Icon(Icons.nightlight)
                          : const Icon(Icons.sunny),
                      title: Text(
                          watch.isDarkMode()
                              ? AppLocalizations.of(context)!.dark_mode
                              : AppLocalizations.of(context)!.light_mode,
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: Switch.adaptive(
                        activeColor: Palette.lightPrimaryColor,
                        onChanged: (_) {
                          watch.switchThemeMode();
                        },
                        value: watch.isDarkMode(),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(AppLocalizations.of(context)!.language,
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: ToggleButtons(
                          isSelected: [!watch.isEnglish(), watch.isEnglish()],
                          renderBorder: true,
                          children: const [
                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  'عربي',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  'English',
                                ),
                              ),
                            ),
                          ],
                          onPressed: (_) {
                            watch.switchLanguage();
                          }),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: Text(AppLocalizations.of(context)!.date_culture,
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: ToggleButtons(
                          isSelected: [
                            watch.isHijri(),
                            !watch.isHijri(),
                          ],
                          renderBorder: true,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.hijri,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.gregorian,
                                ),
                              ),
                            ),
                          ],
                          onPressed: (_) {
                            watch.switchDateCulture();
                          }),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      onTap: () {},
                      title: Text(AppLocalizations.of(context)!.notification,
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: Switch.adaptive(
                        activeColor: Palette.lightPrimaryColor,
                        onChanged: (_) {},
                        value: true,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Consumer<AuthenticationViewModel>(
                      builder: (context, watch, child) => ListTile(
                        leading: const Icon(Icons.logout_outlined),
                        title: Text(AppLocalizations.of(context)!.logout,
                            style: Theme.of(context).textTheme.bodyLarge),
                        trailing: watch.isLoading
                        ? SizedBox(
                          width: 30.h,
                          height: 30.h,
                          child: const CircularProgressIndicator(),
                        )
                        : const SizedBox(),
                        onTap: () async {
                          watch.logout(context: context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
