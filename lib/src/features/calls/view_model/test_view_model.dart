import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/test.dart';

class TestViewModel extends ChangeNotifier{
  static TestModel? _test;

  TestModel? get test => _test??null;

  loadTestResults() async {
    _test = TestModel(mistakes: [
      MistakeType.missSpelling,
      MistakeType.memorization,
      MistakeType.missSpelling,
      MistakeType.missSpelling,
      MistakeType.missSpelling,
      MistakeType.memorization,
    ]);
  }
}