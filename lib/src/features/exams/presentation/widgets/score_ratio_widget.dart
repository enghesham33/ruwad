import 'package:activity_ring/activity_ring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreRatioContent extends StatefulWidget {
  const ScoreRatioContent({
    super.key,
    required this.ratio,
  });

  final double ratio;

  @override
  State<ScoreRatioContent> createState() => _ScoreRatioContentState();
}

class _ScoreRatioContentState extends State<ScoreRatioContent>
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
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
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
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          AppLocalizations.of(context)!.score_ratio,
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Ring(
                      percent: widget.ratio,
                      color: RingColorScheme(
                          ringColor: Palette.lightPrimaryColor,
                          backgroundColor: Palette.gray.withOpacity(0.5)),
                      radius: 60.h,
                      width: 8,
                      child: Center(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: widget.ratio),
                          duration: const Duration(seconds: 2),
                          // Adjust the duration as needed
                          builder: (context, double score, child) {
                            return Text(
                              score.toStringAsFixed(1),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 24),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
