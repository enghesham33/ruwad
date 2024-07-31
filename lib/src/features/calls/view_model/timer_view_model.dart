import 'dart:async';

import 'package:flutter/material.dart';

class TimerViewModel extends ChangeNotifier {
  Timer? _timer;
  ValueNotifier<int> remainingTime = ValueNotifier<int>(60); // 60 is the starting time
  VoidCallback? onTimerEnd;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer?.cancel();
        if (onTimerEnd != null) {
          onTimerEnd!();
        }
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}