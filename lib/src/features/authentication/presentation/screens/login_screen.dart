import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/widgets/custom_phone_input.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/widgets/buttons/custom_main_button.dart';

import '../widgets/custom_login_password_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String _phoneNumber = "";
  String _password = "";

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<SettingsViewModel>(
                builder: (context, watch, child) => GestureDetector(
                  onTap: () => watch.switchLanguage(),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(watch.currentLanguage == Constants.ar ? Constants.en : Constants.arLetter,
                            style: Theme.of(context).textTheme.bodyLarge, ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomPhoneInput(
                phoneController: phoneController,
                onSaved: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                  print("Login$_phoneNumber");
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLoginPasswordInput(
                passwordController: passwordController,
                onSaved:  (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              Consumer<AuthenticationViewModel>(
                builder: (context, watch, _) => CustomMainButton(
                    title: AppLocalizations.of(context)!.login,
                    child: watch.isLoading
                        ? SizedBox(
                            width: 30.h,
                            height: 30.h,
                            child: const CircularProgressIndicator(),
                          )
                        : null,
                    onPress: () async {
                      if (watch.isLoading) {
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await watch.loginByPhoneAndPass(context: context, phone: _phoneNumber, password: _password);
                        // await watch.verifyPhoneNumber(phoneNumber: _phoneNumber, context: context);
                      }
                    }),
              ),
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("Registration");
                  },
                  child: Text(
                    AppLocalizations.of(context)!.to_registration,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
