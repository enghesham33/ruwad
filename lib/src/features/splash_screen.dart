import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';

// import 'package:rawdat_hufaz/src/features/sample/presentation/screens/sample_screen.dart';

import '../shared/app_assets.dart';
import 'authentication/view_model/authentication_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthenticationViewModel? _authenticationViewModel;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      // initialize authentication provider
      _authenticationViewModel =
          Provider.of<AuthenticationViewModel>(context, listen: false);

      // check if user logged in
      // await _authenticationViewModel!.isAuthenticated(context: context);

      // check if credentials are available and login
      await _authenticationViewModel!.splashInit(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 4/1,
              child: Image.asset(
                AppAssets.APP_ICON,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            AppLocalizations.of(context)!.rawdat_alhufaz,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Consumer<AuthenticationViewModel>(
              builder: (context, watch, child) => watch.isLoading
                  ? SizedBox(
                    width: 30.h,
                    height: 30.h,
                    child: const CustomLoadingIndicator(),
                  )
                  : SizedBox(
                    width: 30.h,
                    height: 30.h,
                  ),
            ),
          ),
        ],
      ),
    ));
  }
}
