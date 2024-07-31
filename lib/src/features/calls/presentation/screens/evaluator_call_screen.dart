import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 

class EvaluatorCallScreen extends StatelessWidget {
  final String roomId;
  const EvaluatorCallScreen({super.key, required this.roomId});



  @override
  Widget build(BuildContext context) {
    final callRequestViewModel = Provider.of<CallRequestViewModel>(context);    
    return Scaffold(
      body: 
      Stack(
        children: [
          ZegoUIKitPrebuiltCall(
            appID: Constants.callAppID,
            appSign: Constants.callAppSign,
            userID: AuthenticationViewModel.user!.personId!, // evaluator
            userName: AuthenticationViewModel.user!.name!,
            callID: roomId,

            events: ZegoUIKitPrebuiltCallEvents(
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
                          title: Text(AppLocalizations.of(context)!.end_exam,),
                          content: Text(AppLocalizations.of(context)!.end_exam_confirmation),
                          actions:[
                            ElevatedButton(
                              child:  Text(AppLocalizations.of(context)!.cancel,
                                  style: const TextStyle(color: Colors.white70)),
                                  onPressed: () => Navigator.of(context).pop(false),
                            ),

                            ElevatedButton(
                              child:  Text(AppLocalizations.of(context)!.end_call,
                                  style: const TextStyle(color: Colors.white70)),
                                  onPressed: () async
                                  {
                                   Navigator.of(context).pop(true);
                                   ZegoUIKitPrebuiltCallController().hangUp(context);

              
                                  }
                            ),

                            ElevatedButton(
                              child:  Text(AppLocalizations.of(context)!.yes),
                              onPressed: () async
                              {
                               
                               callRequestViewModel.submitExam();  
                               ZegoUIKitPrebuiltCallController().hangUp(context);
                               Navigator.of(context).pop(true);                            
                                 
                              }
                            ),
                          ],
                         );

                       }
                  );

               },
               onCallEnd: (event, defaultAction) 
               {
                return defaultAction.call();
               },

               
              // onCallEnd: (event, defaultAction) 
              // {
              //    if(event.reason.name == ZegoCallEndReason.localHangUp.name)
              //    {
              //       callRequestViewModel.submitExam();
              //    }
                 
              //    return defaultAction.call();
              // },
            ),

            

            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()

            
        
            ..bottomMenuBar=ZegoCallBottomMenuBarConfig(
              hideAutomatically: false,
               hideByClick: false,
               buttons: 
               [
                ZegoCallMenuBarButtonName.toggleMicrophoneButton,
                ZegoCallMenuBarButtonName.hangUpButton,
                ZegoCallMenuBarButtonName.switchAudioOutputButton,
               ]
               
               
               )
            ..duration=ZegoCallDurationConfig(
              onDurationUpdate: (duration) => 
              {
                if (duration.inSeconds >= 1 * 60) {
                  ZegoUIKitPrebuiltCallController().hangUp(context)
                  

               }
              },)
              ..avatarBuilder=(context, size, user, extraInfo) => Container()
              
              
       

            
          ),
          Positioned(
             bottom: 320,
             left: 20,
             right: 20,
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.memorize_mistakes),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        callRequestViewModel.updateMemorizeMistakes(
                          count: callRequestViewModel.request!.memorizeMistakes! + 1,
                        );
                      },
                      child: Text(
                        '+',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
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
                    TextButton(
                      onPressed: () {
                        if (callRequestViewModel.request!.memorizeMistakes != 0) {
                          callRequestViewModel.updateMemorizeMistakes(
                            count: callRequestViewModel.request!.memorizeMistakes! - 1,
                          );
                        }
                      },
                      child: Text(
                        '-',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50,),
                Text(AppLocalizations.of(context)!.missSpelling_mistake),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        callRequestViewModel.updateSoundMistake(
                          count: callRequestViewModel.request!.soundsMistakes! + 1,
                        );
                      },
                      child: Text(
                        '+',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
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
                    TextButton(
                      onPressed: () {
                        if (callRequestViewModel.request!.soundsMistakes != 0) {
                          callRequestViewModel.updateSoundMistake(
                            count: callRequestViewModel.request!.soundsMistakes! - 1,
                          );
                        }
                      },
                      child: Text(
                        '-',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        
        ],
      )
    );
  }
}
