import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DefaultNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry margin;
  final BoxShape shape;

  DefaultNetworkImage(
      {this.url,
      this.width,
      this.height,
      this.fit,
      this.borderRadius,
      this.margin,
      this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '')
      return Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(
              image: AssetImage('assets/placeholder.jpg'),
              fit: fit,
            )),
      );
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (_, provider) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(
              image: provider,
              fit: fit,
            )),
      ),
      errorWidget: (_, __, ___) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(
              image: AssetImage('assets/placeholder.jpg'),
              fit: fit,
            )),
      ),
      placeholder: (_, __) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: shape,
            image: DecorationImage(
              image: AssetImage('assets/placeholder.jpg'),
              fit: fit,
            )),
      ),
    );
  }
}
