import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Color fillColor;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final double progress;

  const LinearProgress({
    this.height = 4,
    @required this.backgroundColor,
    @required this.fillColor,
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.progress = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration:
      BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
      width: double.infinity,
      alignment: (Localizations.localeOf(context) == Locale('en')
          ? Alignment.centerLeft
          : Alignment.centerRight),
      margin: margin,
      child: FractionallySizedBox(
        widthFactor: progress,
        child: Container(
          height: height,
          decoration:
          BoxDecoration(color: fillColor, borderRadius: borderRadius),
          width: double.infinity,
        ),
      ),
    );
  }
}