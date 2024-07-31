import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/certificate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_progress_bar.dart';

class CustomSectionContainer extends StatelessWidget {
  const CustomSectionContainer({super.key, required this.section, required this.size});

  final SectionModel section;
  final Size size;

  final Widget horizontalSpacer = const SizedBox(
    height: 16,
  );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: CustomBigContainer(
        size: size,
        color: Theme.of(context).cardColor,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(section.name ?? "",
              style: Theme.of(context).textTheme.bodyLarge),
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.total_score,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${section.totalScore}  ${AppLocalizations.of(context)!.from}  ${section.targetTotalScore!.toInt()}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpacer,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded( 
                    child: Text(
                      AppLocalizations.of(context)!.tasks_score,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: CustomProgressBar(
                      size: size,
                      value: (section.tasksScore! / section.targetTasksScore!) ,
                      isPercentage: false,
                      showValues: true,
                      outOf: section.targetTasksScore!,
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpacer,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.exams_score,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: CustomProgressBar(
                      size: size,
                      value: (section.examsScore! / section.targetExamsScore!) ,
                      isPercentage: false,
                      showValues: true,
                      outOf: section.targetExamsScore!,
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpacer,
          ],
        ),
      ),
    );
  }
}
