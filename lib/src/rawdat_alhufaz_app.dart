import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/features/splash_screen.dart';
import 'package:rawdat_hufaz/src/shared/app_routes.dart';
import '../l10n/l10n.dart';
import './shared/themes/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RawdatAlhufazApp extends StatelessWidget {
  const RawdatAlhufazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => Consumer<SettingsViewModel>(
        builder: (context, watch, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "روضة الحفاظ",
          home: const SplashScreen(),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: watch.currentTheme,
          locale: Locale(watch.currentLanguage),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
