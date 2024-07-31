import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class ExamStatus {
  final String titleAr;
  final String titleEn;
  final String value;
  final Color color;

  const ExamStatus({
    required this.titleAr,
    required this.titleEn,
    required this.value,
    required this.color,
  });

  static const ExamStatus future = ExamStatus(titleAr: 'لم يبدأ', titleEn: 'New', value: '0', color: Palette.gray);
  static const ExamStatus available = ExamStatus(titleAr: 'مفتوح', titleEn: 'Available', value: '1', color: Palette.orange);
  static const ExamStatus pendingGrading = ExamStatus(titleAr: 'تحت التقييم', titleEn: 'Pending Grading', value: '2', color: Palette.lightOlive);
  static const ExamStatus graded = ExamStatus(titleAr: 'تم التقييم', titleEn: 'Graded', value: '3', color: Palette.green);
  static const ExamStatus missed = ExamStatus(titleAr: 'فائت', titleEn: 'Missed', value: '4', color: Palette.red);

  static ExamStatus? map(String status) {
    switch (status) {
      case '0':
        return ExamStatus.future;
      case '1':
        return ExamStatus.available;
      case '2':
        return ExamStatus.pendingGrading;
      case '3':
        return ExamStatus.graded;
      case '4':
        return ExamStatus.missed;
      default:
        return null;
    }
  }
}

