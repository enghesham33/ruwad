import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class ExamType {
  final String title;
  final String value;
  final Color color;

  const ExamType(
      {required this.title, required this.value, required this.color});

  static const ExamType ayat = ExamType(title: ' آيات', value: '0', color: Palette.green);
  static const ExamType mawdoaat = ExamType(title: 'موضوعات', value: '1', color: Palette.blue);
  static const ExamType mutshabhat = ExamType(title: 'متشابهات', value: '2', color: Palette.orange);
  static const ExamType review = ExamType(title: 'مراجعة', value: '3', color: Palette.gray);

  static ExamType? map(String type) {
    switch (type) {
      case '0':
        return ExamType.ayat;
      case '1':
        return ExamType.mawdoaat;
      case '2':
        return ExamType.mutshabhat;
      case '3':
        return ExamType.review;
      default:
        return null;
    }
  }
}
