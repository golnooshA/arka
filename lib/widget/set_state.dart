import 'package:flutter/material.dart';

class SetState extends StatefulWidget {

  final Widget Function() builder;
  final SetStateController controller;

  SetState({@required this.builder, @required this.controller});

  @override
  _SetStateState createState() => _SetStateState();
}

class _SetStateState extends State<SetState> {

  @override
  void initState() {
    widget.controller.funcSetState = this.setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}

class SetStateController {
  Function funcSetState;

  setState(){
    if(funcSetState != null){
      funcSetState((){});
    }
  }
}