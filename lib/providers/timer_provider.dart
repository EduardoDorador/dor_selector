import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? timer;
  int winner = 0;

  void startTimer(BuildContext context, TimerProvider timerProvider) {
    print('Timer - Start');
    timer = Timer(const Duration(seconds: 3), () => print('Timer Finished'));
  }
}
