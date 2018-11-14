import 'dart:async';

import 'package:flutter/cupertino.dart';

/**
 * 定时器
 */
class FlutterTimer {
  BuildContext con;
  Widget timeView;
  Timer timer;

  FlutterTimer(this.con, {this.timeView});

  /**
   * 启动定时器
   */
  void startTimer({int duration = 60, TimerEnd endCallback}) {
    timer = Timer.periodic(new Duration(seconds: duration), (Timer timer) {
      if (endCallback != null) {
        endCallback(con, '');
      }
    });
  }

  /**
   * 时间变化操作
   */
  static void startTimerChanged(
      {int duration = 60,
      int period = 1000,
      bool repeat = true,
      String primary,
      bool fromEnd = true,
      @required TimerCounting counting,
      @required TimerEnd end}) async {
    if (fromEnd) {
      for (int i = duration; i >= 0; i--) {
        if (i == 0) {
          if (end != null) {
            end(null, primary);
          }
        } else {
          if (counting != null) {
            counting(i);
          }
        }
        await Future.delayed(new Duration(milliseconds: period));
      }
    } else {
      for (int i = 0; i < duration; i++) {
        if (i <= duration - 1) {
          if (counting != null) {
            counting(i);
          }
        }
        await Future.delayed(new Duration(milliseconds: period));
        if (i == duration - 1) {
          if (repeat) {
            startTimerChanged(
                duration: duration,
                period: period,
                repeat: repeat,
                primary: primary,
                fromEnd: fromEnd,
                counting: counting,
                end: end);
          }
        }
      }
    }
  }

  /**
   * 取消定时器
   */
  void release() {
    if (timer != null) {
      timer.cancel();
    }
  }
}

typedef TimerEnd = void Function(BuildContext con, String data);
typedef TimerCounting = void Function(int count);
