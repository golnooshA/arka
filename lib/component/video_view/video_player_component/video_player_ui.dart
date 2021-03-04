import 'package:flutter/material.dart';
import 'video_player_controller.dart';

abstract class VideoPlayerUI {
  BaseVideoPlayerController controller;

  Widget playButton();

  Widget pauseButton();

  Widget setVolume();

  Widget sliderVideo(double duration, double seekPos, double position,
      Function(double) onChange, Function(double) onChangeEnd);

  Widget fullScreen(Function fullScreenFunc);

  Widget counter(int minutes, int seconds);

  Widget screenRotation();

  void init() {}
}
