import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/request_list_screen.dart';
import 'package:rawdat_hufaz/src/shared/widgets/buttons/custom_main_button.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';

class MainCallPage extends StatefulWidget {
  const MainCallPage({super.key});
  static String routeName = "Call";

  @override
  MainCallPageState createState() => MainCallPageState();
}

class MainCallPageState extends State<MainCallPage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isButtonDisabled = false;


    void _onPress() {
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

    Navigator.of(context).pushNamed(RequestListScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Widget _animatedButton({required String title, required VoidCallback onPress}) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: CustomMainButton(
        title: title,
        onPress: onPress,
        // child: null
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final zegoProvider = context.watch<ZegoCloudProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.calls),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.listen_details,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            
            ),
      
          const SizedBox(height: 50,),
      
          Text(
           AppLocalizations.of(context)!.listen_description,
           style: Theme.of(context).textTheme.bodyMedium,
           textAlign: TextAlign.center,
           
            ),
      
            const SizedBox(height: 50),
            _isButtonDisabled? const Center(child:  CustomLoadingIndicator())
            :_animatedButton(
              onPress: _onPress,
              title: AppLocalizations.of(context)!.calls_button,
              
            ),
          ],
        ),
      ),
    );
  }

  
}
