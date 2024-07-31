import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/student_call_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallWaitingScreen extends StatelessWidget {
  const CallWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final callRequestViewModel = Provider.of<CallRequestViewModel>(context);

    // Check the request status
    if (callRequestViewModel.request==null || callRequestViewModel.request!.evaluatorId == null) {
      return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AnimatedHeader(title: "", color: Palette.accentColor, size: MediaQuery.of(context).size,),
              const SizedBox(
                width: 100, height: 100,
                child: CustomLoadingIndicator()),
              Text(AppLocalizations.of(context)!.call_waiting_description,
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(AppLocalizations.of(context)!.please_wait,
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: () async {
                 Navigator.pop(context);
                await callRequestViewModel.delete(AuthenticationViewModel.user!.personId!);
                
                //pop
              }, child: Text(AppLocalizations.of(context)!.cancel))
            ],
          ),
        ),
      );
    } else {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  const StudentCallScreen()),
    );
  });
  return Container();
}

  }
}
