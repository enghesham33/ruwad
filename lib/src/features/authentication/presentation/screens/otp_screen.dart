import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../view_model/authentication_view_model.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int _seconds = 0;
  int _minutes = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds % 60 == 0){
          _seconds = 0;
          _minutes++;
        }
      });
      if( _minutes == 3 ){ //todo: check otp policy
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: keyboardHeight + 350,
      padding: EdgeInsets.only(top: 16, left: 32, right: 32, bottom: keyboardHeight + 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.otp_title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context)!.otp_label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<AuthenticationViewModel>(
            builder: (context, watch, _) => OtpTextField(
              numberOfFields: 6,
              autoFocus: false,
              clearText: true,
              fillColor: Theme.of(context).focusColor,
              cursorColor: Theme.of(context).focusColor,
              focusedBorderColor: Theme.of(context).focusColor,
              showFieldAsBox: true,
              textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).focusColor),
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.center,
              onSubmit: (otp) async {
                if (otp.length == 6) {
                  // await watch.verifyOTP(context: context, otp: otp);
                }
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Center(child: Text('$_minutes:$_seconds')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.otp_not_sent,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Consumer<AuthenticationViewModel>(
                builder: (context, watch, _) => TextButton(
                  onPressed: () {
                    // watch.verifyPhoneNumber(phoneNumber: widget.phoneNumber, context: context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.otp_resend,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
