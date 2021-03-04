import 'package:wood/core/config/design_config.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_player_component/video_player_component.dart';

class SingleVideoPlayer extends StatefulWidget {
  final String videoCover;
  final AptVideoPlayer videoPlayer;

  const SingleVideoPlayer({
    Key key,
    this.videoCover,
    this.videoPlayer,
  }) : super(key: key);

  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  bool showControllers;

  @override
  void initState() {
    showControllers = true;
    widget.videoPlayer.controller.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayer.controller.isFullScreen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).orientation == Orientation.landscape)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height / 3,
          child: (widget.videoPlayer.controller.isInitialize)
              ? Stack(
            children: [
              InkWell(
                onTap: () => showControllers = !showControllers,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).orientation ==
                      Orientation.landscape)
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.height / 3,
                  child: VideoPlayer(
                      widget.videoPlayer.controller.controller),
                ),
              ),
              (showControllers)
                  ? Positioned(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[600].withOpacity(0.8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            width:
                            MediaQuery.of(context).size.width -
                                30,
                            height: 30,
                            child: widget.videoPlayer.sliderVideo(
                                widget.videoPlayer.controller
                                    .controller.value.duration,
                                widget.videoPlayer.controller
                                    .controller.value.position),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            right: 10.0, left: 30.0),
                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            widget.videoPlayer.counter(widget
                                .videoPlayer
                                .controller
                                .controller
                                .value
                                .position
                                .inSeconds),
                            widget.videoPlayer.counter(widget
                                .videoPlayer
                                .controller
                                .controller
                                .value
                                .duration
                                .inSeconds -
                                widget
                                    .videoPlayer
                                    .controller
                                    .controller
                                    .value
                                    .position
                                    .inSeconds),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            right: 10.0, left: 10.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            widget.videoPlayer.setVolume(),
                            widget.videoPlayer.controller.controller
                                .value.isPlaying
                                ? widget.videoPlayer.pauseButton()
                                : widget.videoPlayer.playButton(),
                            widget.videoPlayer.fullScreen(() {
                              widget.videoPlayer.controller
                                  .isFullScreen = false;
                              Navigator.of(context).pop();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(),
            ],
          )
              : Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).orientation ==
                    Orientation.landscape)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.height / 3,
                child: DefaultNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fill,
                  url: (widget.videoCover != null)
                      ? HttpConfig.url(widget.videoCover, isApi: false)
                      : "",
                ),
              ),
              Center(
                child: Loading(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}