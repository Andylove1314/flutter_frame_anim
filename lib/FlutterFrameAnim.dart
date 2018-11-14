import 'package:flutter/material.dart';
import 'package:flutter_frame_anim/FlutterTimer.dart';

class FlutterFrameAnim extends StatefulWidget {
  List<String> paths;
  int periodMilli;

  FlutterFrameAnim(this.paths, {this.periodMilli = 50});

  @override
  State<StatefulWidget> createState() {
    return FlutterFrameAnimState(paths, periodMilli: periodMilli);
  }
}

class FlutterFrameAnimState extends State<FlutterFrameAnim> {
  String currentImage;
  List<String> paths;
  int periodMilli;

  FlutterFrameAnimState(this.paths, {this.periodMilli});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterTimer.startTimerChanged(
        duration: paths.length,
        period: periodMilli,
        fromEnd: false,
        counting: _animing,
        end: null);
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(currentImage);
  }

  void _animing(int count) {
    setState(() {
      currentImage = paths[count];
    });
  }
}
