import 'package:photo_view/photo_view.dart';

import 'on_multi_touch.dart';
import 'package:flutter/material.dart';
import 'gallery_photo_widget.dart';


class GalleryView extends StatefulWidget {

  final List<String> photos;
  final int initialIndex;

  GalleryView({this.photos, this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() => _GalleryViewState();

}

class _GalleryViewState extends State<GalleryView> {

  ScrollPhysics scrollPhysics = ScrollPhysics();

  onTouchDown(){
    setState(() {
      scrollPhysics = NeverScrollableScrollPhysics();
    });
  }

  onTouchUp(){
    setState(() {
      scrollPhysics = ScrollPhysics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnMultiTouch(
      onTouchDown: onTouchDown,
      onTouchUp: onTouchUp,
      child: PageView(
        controller: PageController(initialPage: widget.initialIndex ?? 0),
        physics: scrollPhysics,
        children: widget.photos.map((e) => GalleryPhoto(
          url: e,
          onTouchUp: onTouchUp,
          onTouchDown: onTouchDown,
        )).toList(),
      ),
    );

  }

}