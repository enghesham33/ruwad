import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/features/wallet/view_model/points_view_model.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class StudentCallScreen extends StatefulWidget {
  static String routeName = "StudentCallScreen";
  const StudentCallScreen({super.key});

  @override
  State<StudentCallScreen> createState() => _StudentCallScreenState();
}

class _StudentCallScreenState extends State<StudentCallScreen> {


@override
Widget build(BuildContext context) {

final callRequestViewModel = Provider.of<CallRequestViewModel>(context);
final pointsViewModel = Provider.of<PointsViewModel>(context);

  // if (callRequestViewModel.request == null) {
  //   //todo :: notification to check exam result.
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //   Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
  //   });
  // }
      return Scaffold(
        body: callRequestViewModel.request!=null?
        Stack(
          children: [
            ZegoUIKitPrebuiltCall(

                  appID: Constants.callAppID,
                  appSign: Constants.callAppSign,
                  userID: AuthenticationViewModel.user!.personId!, // evaluator
                  userName: AuthenticationViewModel.user!.name!,
                  callID: callRequestViewModel.request?.roomId??"",
                  config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
                  ..avatarBuilder=(context, size, user, extraInfo) => Container(),
                  events:
                  ZegoUIKitPrebuiltCallEvents(


                  onHangUpConfirmation:(ZegoCallHangUpConfirmationEvent event,
                  Future<bool> Function() defaultAction,) async
                  {
                  return await showDialog
                  (
                      context: event.context,
                      barrierDismissible: false,
                       builder: (BuildContext context)
                       {
                         return AlertDialog
                         (
                          title: Text(AppLocalizations.of(context)!.end_exam),
                          content: Text(AppLocalizations.of(context)!.end_exam_confirmation),
                          actions:[
                            ElevatedButton(
                              child:  Text(AppLocalizations.of(context)!.cancel,
                                  style: const TextStyle(color: Colors.white70)),
                                  onPressed: () {Navigator.of(context).pop(false);
                                  }
                            ),

                            ElevatedButton(
                              child:  Text(AppLocalizations.of(context)!.end_call,
                                  style: const TextStyle(color: Colors.white70)),
                                  onPressed: () async
                                  {
                                    print("object");
                                   Navigator.of(context).pop(true);
                                   ZegoUIKitPrebuiltCallController().hangUp(context);
                                   pointsViewModel.consumePoints();


                                  }
                            ),

                          ],
                         );

                       }
                  );

               },
               onCallEnd: (event, defaultAction) async
               {
                 print("bananssss");
                if(mounted) {
                  print("eeeeeeeeeeeeeeeeeeeeeeeeeeee");
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.of(context).pop(true);
                  // });
                  //
                  // ZegoUIKitPrebuiltCallController().hangUp(context);
                  // pointsViewModel.consumePoints();
                 // defaultAction.call();


                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomeScreen()));
                  });

                }


               },


            ),



                )

                ,
                 Positioned(
                 bottom: 320,
                 left: 20,
                 right: 20,
                  child: Column(
                  children: [
                Text(AppLocalizations.of(context)!.memorize_mistakes),
                Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.lightAccentColor,
                      ),
                      child: Center(
                        child: Text(
                          callRequestViewModel.request!.memorizeMistakes!.toString(),
                        ),
                      ),
                    ),
                const SizedBox(height: 50,),
                Text(AppLocalizations.of(context)!.missSpelling_mistake),
                Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.lightAccentColor,
              ),
               child: Center(
                child: Text(
                  callRequestViewModel.request!.soundsMistakes!.toString(),
                ),
              ),
            ),

              ],
                )

        )])
       : const SizedBox.shrink()

    );
  }
}
