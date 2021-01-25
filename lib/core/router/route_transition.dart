import 'package:flutter/material.dart';

class DefaultRouteTransition extends SlideTransition {

  final Widget child;
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;

  DefaultRouteTransition({
    this.child,
    this.animation,
    this.secondaryAnimation
  }) : super(
    transformHitTests: false,
    position: new Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(animation),
    child: new SlideTransition(
      position: new Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1.0, 0.0),
      ).animate(secondaryAnimation),
      child: child,
    ),
  );
}