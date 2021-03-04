import 'package:video_player/video_player.dart';

abstract class BaseVideoPlayerController {
  VideoPlayerController controller;
  bool isFullScreen = false;
  bool isMuted = false;
  bool isInitialize = false;
  bool isLoading = false;
  Future<void> init();
  void play();
  void pause();
  void seekTo(Duration position);
  void setVolume(bool mute);
  void syncVideo();
  Future<void> dispose();
}
