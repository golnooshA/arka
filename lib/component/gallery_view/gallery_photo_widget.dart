import 'package:wood/core/config/design_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GalleryPhoto extends StatefulWidget {

  final String url;
  final Function onTouchUp;
  final Function onTouchDown;

  GalleryPhoto({
    this.url,
    this.onTouchUp,
    this.onTouchDown
  });

  @override
  State<StatefulWidget> createState() => _GalleryPhotoState();

}

class _GalleryPhotoState extends State<GalleryPhoto> {


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CachedNetworkImage(
      //cacheManager: CustomCacheManager.instance,
      imageUrl: widget.url,
      width: width,
      height: height,
      fit: BoxFit.contain,
      imageBuilder: (_, provider) => Stack(
        children: [
          PhotoView(
            scaleStateChangedCallback: (PhotoViewScaleState state){
              if(state.index == 0){
                widget.onTouchUp();
              } else {
                widget.onTouchDown();
              }
            },
            minScale: PhotoViewComputedScale.contained,
            initialScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 3,
            imageProvider: provider,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: DesignConfig.errorColor
              ),
            ),
          )
        ],
      ),
      errorWidget: (_, __, ___) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: DesignConfig.errorColor
        ),
      ),
      placeholder: (_, __) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: DesignConfig.errorColor
        ),
      ),
    );
  }

}