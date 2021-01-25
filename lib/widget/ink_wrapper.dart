import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  final Color splashColor;
  final Color highlightColor;
  final Widget child;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  InkWrapper({
    this.splashColor,
    this.highlightColor,
    @required this.child,
    @required this.onTap,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              splashColor: splashColor,
              highlightColor: highlightColor,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}