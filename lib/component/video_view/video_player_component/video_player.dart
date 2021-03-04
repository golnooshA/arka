import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'video_player_controller.dart';
import 'video_player_ui.dart';

class AptVideoPlayer {
  VideoPlayerUI ui;
  BaseVideoPlayerController controller;

  AptVideoPlayer({this.ui, this.controller}) {
    /// Pass the current Controller to UI class and then initialize this class.
    ui.controller = controller;
    ui.init();
  }

  Widget playButton() {
    return ui.playButton();
  }

  Widget pauseButton() {
    return ui.pauseButton();
  }

  Widget setVolume() {
    return ui.setVolume();
  }

  Widget sliderVideo(Duration duration, Duration position) {
    double seekPos;
    BehaviorSubject<double> _dragPositionSubject = BehaviorSubject.seeded(null);

    void _onChange(double value) {
      _dragPositionSubject.add(value);
    }

    void _onChangeEnd(double value) {
      controller.seekTo(Duration(milliseconds: value.toInt()));
      seekPos = value;
      _dragPositionSubject.add(null);
    }

    return StreamBuilder(
        stream: Rx.combineLatest2<double, double, double>(
            _dragPositionSubject.stream,
            Stream.periodic(Duration(milliseconds: 10)),
            (dragPosition, _) => dragPosition),
        builder: (context, snapshot) {
          if (duration != null && position != null) {
            double currentPosition =
                snapshot.data ?? position.inMilliseconds.toDouble();
            double currentDuration = duration.inMilliseconds.toDouble();
            return ui.sliderVideo(currentDuration, seekPos, currentPosition,
                _onChange, _onChangeEnd);
          }
          return ui.sliderVideo(0.0, seekPos, 0.0, _onChange, _onChangeEnd);
        });
  }

  Widget fullScreen(Function fullScreenFunc) {
    return ui.fullScreen(fullScreenFunc);
  }

  Widget counter(int value) {
    return ui.counter(
        MinutesSeconds(value).getMinutes(), MinutesSeconds(value).getSeconds());
  }

  Widget screenRotation() {
    return ui.screenRotation();
  }
}

class MinutesSeconds {
  int _mins;
  int _secs;

  MinutesSeconds(int totalSeconds) {
    _mins = (totalSeconds / 60).floor();
    _secs = totalSeconds - (_mins * 60);
  }

  int getSeconds() {
    return _secs;
  }

  int getMinutes() {
    return _mins;
  }
}
