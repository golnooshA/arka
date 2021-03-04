import 'dart:math';
import 'package:wood/core/config/design_config.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:wood/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'video_player_component/video_player_component.dart';

class MyVideoPlayerUI extends VideoPlayerUI {
  final BuildContext context;

  MyVideoPlayerUI({this.context});

  @override
  Widget playButton() {
    return (!controller.controller.value.isBuffering)
        ? InkWrapper(
      borderRadius: BorderRadius.circular(80),
      splashColor: DesignConfig.errorColor.withOpacity(0.5),
      highlightColor: DesignConfig.highlightColor,
      onTap: () {
        controller.play();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
        ),
        child: Icon(
          Icons.play_arrow,
          color: DesignConfig.titleColor,
        ),
      ),
    )
        : Container(width: 60.0, height: 60.0, child: Loading(), decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
    ),);
  }

  @override
  Widget pauseButton() {
    return (!controller.controller.value.isBuffering)
        ? InkWrapper(
      borderRadius: BorderRadius.circular(80),
      splashColor: DesignConfig.errorColor.withOpacity(0.5),
      highlightColor: DesignConfig.highlightColor,
      onTap: () {
        controller.pause();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
        ),
        width: 60,
        height: 60,
        child: Icon(
          Icons.pause,
          color: DesignConfig.titleColor,
        ),
      ),
    )
        : Container(width: 60.0, height: 60.0, child: Loading());
  }

  @override
  Widget counter(int minutes, int seconds) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Text(
        '${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11.0, color: Colors.white),
      ),
    );
  }

  @override
  Widget fullScreen(Function fullScreenFunc) {
    return IconButton(
      icon: Icon(
        controller.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
        color: Colors.white,
        size: 20,
      ),
      onPressed: () {
        fullScreenFunc();
      },
    );
  }

  @override
  Widget screenRotation() {
    return IconButton(
        icon: Icon(
          Icons.rotate_90_degrees_ccw_sharp,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
            ]);
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          }
        });
  }

  @override
  Widget setVolume() {
    return IconButton(
      icon: Icon(
        controller.isMuted ? Icons.volume_mute : Icons.volume_down,
        color: Colors.white,
        size: 20,
      ),
      onPressed: () {
        if (controller.isMuted)
          controller.setVolume(false);
        else
          controller.setVolume(true);
      },
    );
  }

  @override
  Widget sliderVideo(double duration, double seekPos, double position,
      Function(double) onChange, Function(double) onChangeEnd) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Slider(
        min: 0.0,
        max: duration,
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        value: seekPos ?? max(0.0, min(position, duration)),
        onChanged: (value) {
          onChange(value);
        },
        onChangeEnd: (value) {
          onChangeEnd(value);
        },
      ),
    );
  }
}