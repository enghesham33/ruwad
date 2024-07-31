import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/types/exam_status.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/types/exam_type.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';

import '../../../settings/view_model/settings_view_model.dart';
import '../../data/models/exam.dart';
import '../../data/models/types/badge_type.dart';

class BadgesWidget extends StatelessWidget {
  const BadgesWidget({
    super.key,
    required this.exam,
  });

  final ExamModel exam;

  @override
  Widget build(BuildContext context) {

    final List<BadgeType> badges = [];
    if (exam.userScore == exam.targetScore){
      badges.add(BadgeType.fullMark);
    }
    if (exam.type == ExamType.review && exam.isDone!){
      badges.add(BadgeType.hardWorker);
    }
    if (exam.isHighest!){
      badges.add(BadgeType.highestMark);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
            child: Text(
                AppLocalizations.of(context)!.badges,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: badges
                      .map((badge) => InkWell(
                    onTap: (){
                      CustomDialog(context).showMessage(
                        message: context
                            .read<SettingsViewModel>()
                            .isEnglish()
                            ? badge.descriptionEn
                            : badge.descriptionAr,
                      );
                    },
                        child: Padding(
                              padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                              child: SizedBox(
                                width: 80.h,
                                height: 70.h,
                                child: Image.asset(
                                  badge.imageURL,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                      ))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
