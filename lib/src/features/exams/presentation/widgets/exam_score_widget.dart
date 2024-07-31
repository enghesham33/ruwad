import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class ExamScoreContent extends StatefulWidget {
  const ExamScoreContent({
    super.key,
    required this.userScore,
    required this.targetScore,
    this.color = Palette.lightPrimaryColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.title,
  });

  final double userScore;
  final double targetScore;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;
  final String title;

  @override
  State<ExamScoreContent> createState() => _ExamScoreContentState();
}

class _ExamScoreContentState extends State<ExamScoreContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Constants.animationMilliSeconds,
    );
    _animation =
        Tween<double>(begin: 0.5, end: 1.0).animate(_animationController);
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
                crossAxisAlignment: widget.crossAxisAlignment,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: widget.userScore),
                        duration: const Duration(seconds: 2),
                        // Adjust the duration as needed
                        builder: (context, double score, child) {
                          return Text(
                            score.toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: widget.color, fontSize: 24),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      Text(
                        " / ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.targetScore.ceil().toStringAsFixed(0),
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
