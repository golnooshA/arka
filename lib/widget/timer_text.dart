import 'dart:async';

import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {

  final Duration timeout;
  final Widget Function(int, int, int, int) builder;

  const TimerText({this.timeout, @required this.builder}) : assert(builder != null);

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {

  final period = const Duration(seconds: 1);
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  Timer timer;
  Duration duration;

  @override
  void initState() {
    duration = widget.timeout;
    timer = Timer.periodic(period, (timer) {
      duration = duration - period;
      setState(() {
        days = duration.inDays;
        hours = duration.inHours % 24;
        minutes = duration.inMinutes % 60;
        seconds = duration.inSeconds % 60;
        print('$days, $hours, $minutes, $seconds');
      });
      if(days == 0 && hours == 0 && minutes == 0 && seconds == 0){
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(days, hours, minutes, seconds);
    //return Text('${days > 0 ? days : ''} - ${hours > 9 ? hours : '0$hours'}:${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}', style: widget.style, textDirection: widget.textDirection, textAlign: widget.textAlign,);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}