import 'package:wood/core/config/design_config.dart';
import 'package:wood/widget/set_state.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_view/single_video_player.dart';
import 'video_view/video_player_component/network_video_controller.dart';
import 'video_view/video_player_component/video_player.dart';
import 'video_view/video_player_ui.dart';


class PostVideo extends StatefulWidget {

  final double width;
  final double height;
  final String coverUrl;
  final String videoUrl;

  PostVideo({
    this.width,
    this.height,
    this.coverUrl,
    this.videoUrl
  });

  @override
  _PostVideoState createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  final videoPlayerSetStateController = SetStateController();
  AptVideoPlayer videoPlayer;
  bool showControllers;

  @override
  void initState() {
    videoPlayer = AptVideoPlayer(
      ui: MyVideoPlayerUI(context: context),
      controller: NetworkVideoPlayerController(
        networkPath: widget.videoUrl,
      ),
    );
    videoPlayer.controller.init().then((value){
      videoPlayerSetStateController.setState();
    });
    videoPlayer.controller.isFullScreen = false;
    showControllers = true;
    videoPlayer.controller.controller.addListener(() {
      videoPlayerSetStateController.setState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SetState(
        controller: videoPlayerSetStateController,
        builder: () => videoPlayer.controller.isInitialize
            ? Container(
          width: widget.width,
          height: widget.height,
          child: Stack(
            children: [
              InkWell(
                onTap: (){
                  showControllers = !showControllers;
                  videoPlayerSetStateController.setState();
                },
                child: Container(
                  width: widget.width,
                  height: (MediaQuery.of(context).orientation == Orientation.landscape)
                      ? widget.width
                      : widget.height,
                  child: VideoPlayer(videoPlayer.controller.controller),
                ),
              ),

              if(showControllers) Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: DesignConfig.errorColor.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            width: widget.width,
                            height: 30,
                            child: videoPlayer.sliderVideo(videoPlayer.controller.controller.value.duration,
                                videoPlayer.controller.controller.value.position),
                          ),
                        ],
                      ),
                      Container(
                        width: widget.width,
                        padding: EdgeInsets.only(right: 10.0, left: 30.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            videoPlayer.counter(videoPlayer.controller.controller.value.position.inSeconds),
                            videoPlayer.counter(videoPlayer.controller.controller.value.duration.inSeconds -
                                videoPlayer.controller.controller.value.position.inSeconds),
                          ],
                        ),
                      ),
                      Container(
                        width: widget.width,
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            videoPlayer.setVolume(),
                            videoPlayer.controller.controller.value.isPlaying
                                ? videoPlayer.pauseButton()
                                : videoPlayer.playButton(),
                            videoPlayer.fullScreen(() {
                              videoPlayer.controller.isFullScreen = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SingleVideoPlayer(
                                    videoCover: widget.coverUrl ?? '',
                                    videoPlayer: videoPlayer,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ) : Container(
          width: widget.width,
          height: widget.height,
          color: DesignConfig.errorColor,
        )
    );
  }

  @override
  void dispose() {
    if(videoPlayer != null){
      videoPlayer.controller.dispose();
    }
    super.dispose();
  }
}