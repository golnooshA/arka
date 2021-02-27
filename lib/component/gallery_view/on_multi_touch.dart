import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  MultiTouchGestureRecognizerCallback onMultiTapDown;
  MultiTouchGestureRecognizerCallback onMultiTapUp;
  var numberOfTouches = 0;
  int minNumberOfTouches;

  MultiTouchGestureRecognizer({this.minNumberOfTouches = 2}) {
    super.onTapDown = (pointer, details) => this.addTouch(pointer, details);
    super.onTapUp = (pointer, details) => this.removeTouch(pointer, details);
    super.onTapCancel = (pointer) => this.cancelTouch(pointer);
    super.onTap = (pointer) => this.captureDefaultTap(pointer);
  }

  void addTouch(int pointer, TapDownDetails details) {
    this.numberOfTouches++;

    if (this.numberOfTouches == this.minNumberOfTouches) {
      this.onMultiTapDown(true);
    }
  }

  void removeTouch(int pointer, TapUpDetails details) {

    this.onMultiTapUp(true);

    this.numberOfTouches = 0;
  }

  void cancelTouch(int pointer) {
    this.numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onTapDown(_onTouchDown) {}

  @override
  set onTapUp(_onTouchUp) {}

  @override
  set onTapCancel(_onTapCancel) {}

  @override
  set onTap(_onTap) {}
}

class OnMultiTouch extends StatelessWidget {

  final Function onTouchDown;
  final Function onTouchUp;
  final Widget child;
  final int minTouchNumber;

  OnMultiTouch({Function onTouchDown, Function onTouchUp, this.child, this.minTouchNumber = 2}) :
        this.onTouchUp = onTouchUp == null ? ((){}) : onTouchUp,
        this.onTouchDown = onTouchDown == null ? ((){}) : onTouchDown;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        MultiTouchGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            MultiTouchGestureRecognizer>(
              () => MultiTouchGestureRecognizer(minNumberOfTouches: minTouchNumber),
              (MultiTouchGestureRecognizer instance) {
            instance.onMultiTapDown = (correctNumberOfTouches) => this.onTouchDown();
            instance.onMultiTapUp = (correctNumberOfTouches) => this.onTouchUp();
          },
        ),
      },
      child: child,
    );
  }

}

typedef MultiTouchGestureRecognizerCallback = void Function(bool correctNumberOfTouches);