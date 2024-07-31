import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/call_waiting_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/shared/widgets/buttons/custom_main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';

class CallRequestButton extends StatefulWidget {
  final num? examId;
  final String quorum;
  final bool isOralAssesment;

  const CallRequestButton({super.key, this.examId, required this.quorum, required this.isOralAssesment});

  @override
  State<CallRequestButton> createState() => _CallRequestButtonState();
}

class _CallRequestButtonState extends State<CallRequestButton> {
    bool _isButtonDisabled = false;


    void _disableButton() {
    if(_isButtonDisabled) return;
    
    setState(() {
      _isButtonDisabled = true;
    });

    Timer(const Duration(minutes: 1), () {
      if (mounted) {
        setState(() {
          _isButtonDisabled = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CallRequestViewModel>(
                         builder: (context, req, child)=> 
                         _isButtonDisabled?
                         const Center(child:  CustomLoadingIndicator())                      
                         :CustomMainButton(
                                  title: "",
                                  child: Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: Text(AppLocalizations.of(context)!.button_do_test,
                                    style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  onPress: () async
                                  {    
                                     _disableButton();
                                     
                                     await req.create(examId: widget.examId, quorum: widget.quorum,isOralAssesment: widget.isOralAssesment).then((value) 
                                     {
                                      Navigator.pushReplacement(
                                       context,
                                       MaterialPageRoute(builder: (context) => const CallWaitingScreen()),
                                     ); 
                                     });
     
                                  }),
                 );
  }
}