import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/widgets/call_request_button.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/daily_tasks_view_model.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_tag.dart';
import '../../data/models/task.dart';

class CustomTaskRow extends StatefulWidget {
  const CustomTaskRow({
    super.key,
    required this.task,
    required this.progress,
    required this.increment,
    // required this.onChanged,
    required this.submitScore,
    required this.reset,
  });

  final TaskModel task;
  final double progress;
  final void Function() increment;

  // final Function(int) onChanged;
  final void Function(int) submitScore;
  final void Function() reset;

  @override
  State<CustomTaskRow> createState() => _CustomTaskRowState();
}

class _CustomTaskRowState extends State<CustomTaskRow> {
  // late int _selectedScore;

  void _showResetMenu({
    required BuildContext context,
  }) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox target = context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromSize(
      Rect.fromPoints(
        target.localToGlobal(Offset.zero, ancestor: overlay),
        target.localToGlobal(target.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      overlay.size,
    );

    // Show the menu using showMenu function
    showMenu(
      context: context,
      position: position,
      items: <PopupMenuEntry>[
        // Add your menu items here
        PopupMenuItem(
            onTap: widget.reset,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.refresh),
                Text(
                  AppLocalizations.of(context)!.reset,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          widget.task.maxRepetitions<=10
          ?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                   GestureDetector(
                      onTap: widget.increment,
                      onLongPress: () => _showResetMenu(context: context),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).canvasColor,
                          boxShadow: [AppStyles.containerBoxShadow],
                        ),
                        child: CircularPercentIndicator(
                          radius: 20,
                          lineWidth: 5,
                          animation: true,
                          animateFromLastPercent: true,
                          backgroundWidth: 5,
                          backgroundColor: Palette.lightAccentColor,
                          percent: widget.progress,
                          center: Text(
                            widget.task.userRepetitions ==
                                widget.task.maxRepetitions
                                ? '✓'
                                : widget.task.userRepetitions == 0
                                ? widget.task.maxRepetitions
                                .toStringAsFixed(0)
                                : (widget.task.maxRepetitions -
                                widget.task.userRepetitions)
                                .toStringAsFixed(0),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          progressColor: Palette.accentColor,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.task.type!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              widget.task.isOptional!
                  ? CustomTag(
                onPressed: () => CustomDialog(context).showMessage(
                  message: AppLocalizations.of(context)!
                      .message_title_optional_task,
                ),
                text: AppLocalizations.of(context)!
                    .message_title_optional_task,
                foregroundColor: Palette.lightAccentColor,
                borderColor: Palette.lightAccentColor,
              )
              : const SizedBox(),
               widget.task.helpText!.isNotEmpty
              ? IconButton
              (icon: const Icon(Icons.info_outline, color:Palette.lightAccentColor),
               onPressed: () => CustomDialog(context).showMessage(
                  message: widget.task.helpText!,
                )
              )
              : const SizedBox(),
            ],
          )
          :Container
          (
            decoration: const BoxDecoration
            (
              color: Colors.white10,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topLeft: Radius.circular(50))
           
          
            ),
            child:  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                                child: Text(
                                  widget.task.type!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
              widget.task.helpText!.isNotEmpty
              ? IconButton
              (icon: const Icon(Icons.info_outline, color:Palette.lightAccentColor),
               onPressed: () => CustomDialog(context).showMessage(
                  message: widget.task.helpText!,
                )
              )
              : const SizedBox(),
              ],
                  ),
                     Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row
                          (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: 
              [
              
              Expanded(
                child: Text(AppLocalizations.of(context)!.score, style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Expanded(
                child: Row
                (
                  children: 
                  [
                    Text(widget.task.userRepetitions.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.titleLarge,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("/",
                      style: Theme.of(context).textTheme.titleMedium,
                     ),
                   ),
                   Text(widget.task.maxRepetitions.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.titleMedium,
                   ),
                  ],
                ),
              ),
              

                ],
    ),
  ),
  Consumer<DailyTasksViewModel>(
                         builder: (context, day, child)=> 
                            CallRequestButton(examId: widget.task.id,
                            quorum: day.day.quota??"",
                            isOralAssesment: true,)
                         
                 ) 
                 
                ],
              ),
            ),
          )            
        ],
      
        
      ),
    );
  }
}