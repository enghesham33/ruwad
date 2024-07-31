import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';

class QuestionsCountContent extends StatefulWidget {
  const QuestionsCountContent({super.key, required this.count, });

  final int count;

  @override
  State<QuestionsCountContent> createState() => _QuestionsCountContentState();
}

class _QuestionsCountContentState extends State<QuestionsCountContent> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Constants.animationMilliSeconds,
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:  16,),
                    child: Text(
                      AppLocalizations.of(context)!.questions_count,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: widget.count.toDouble()),
                    duration: const Duration(seconds: 2), // Adjust the duration as needed
                    builder: (context, double count, child) {
                      return Text(
                        count.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                 
                ],
              ),
            ),
          );}
    );
  }
}
