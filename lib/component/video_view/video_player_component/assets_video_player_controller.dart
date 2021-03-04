import 'package:video_player/video_player.dart';
import 'video_player_controller.dart';

class AssetsVideoPlayerController extends BaseVideoPlayerController {
  final String assetsPath;

  AssetsVideoPlayerController({this.assetsPath}) {
    controller = VideoPlayerController.asset(assetsPath);
  }

  @override
  Future<void> init() async {
    isLoading = true;
    await controller.initialize().then((value) {
      isInitialize = true;
      isLoading = false;
    });
  }

  @override
  void pause() {
    controller.pause();
  }

  @override
  void play() async {
    if (!isInitialize) {
      await init().then((value) => controller.play());
    } else if (controller.value.position == controller.value.duration) {
      controller
          .seekTo(Duration(seconds: 0))
          .then((value) => controller.play());
    } else {
      controller.play();
    }
  }

  @override
  void setVolume(bool mute) {
    if (mute) {
      isMuted = true;
      controller.setVolume(0.0);
    } else {
      isMuted = false;
      controller.setVolume(1.0);
    }
  }

  @override
  void syncVideo() {
    // writting soon...
  }

  @override
  Future<void> dispose() async {
    await controller.dispose();
  }

  @override
  void seekTo(Duration position) async {
    if (controller.value.position == controller.value.duration) {
      controller.seekTo(position).then((value) => pause());
    } else {
      await controller.seekTo(position);
    }
  }
}
