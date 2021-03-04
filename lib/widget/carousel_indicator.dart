import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {

  final Widget child;
  final Widget selectedChild;
  final int count;
  final int initialIndex;
  final CarouselIndicatorController controller;

  CarouselIndicator({
    @required this.child,
    @required this.selectedChild,
    this.initialIndex = 0,
    this.count = 0,
    CarouselIndicatorController controller
  }) : this.controller = controller ?? CarouselIndicatorController();


  @override
  _CarouselIndicatorState createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {

  List<Widget> _indicators;

  @override
  void initState() {
    _setIndicators(widget.initialIndex);
    widget.controller.setState = (int index) {
      setState(() {
        _setIndicators(index);
      });
    };
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: _indicators,
    );
  }

  void _setIndicators(int current){
    _indicators = [];
    for(int i=0; i<widget.count; i++){
      _indicators.add(i == current ? widget.selectedChild : widget.child);
    }
  }
}

class CarouselIndicatorController {
  Function(int) setState;

  void setIndex(int index){
    setState(index);
  }
}
