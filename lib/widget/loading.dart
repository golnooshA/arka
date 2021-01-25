import 'package:flutter/material.dart';
import 'package:wood/core/config/design_config.dart';

class Loading extends StatelessWidget {

  final EdgeInsetsGeometry margin;

  const Loading({this.margin = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: margin,
      child: CircularProgressIndicator(
        backgroundColor: DesignConfig.secondaryAppBarColor,
      ),
    );
  }
}
