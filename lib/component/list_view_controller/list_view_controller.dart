import 'package:flutter/material.dart';

class ListViewController {
  final ScrollController scrollController;
  double offset;
  bool _canDoReachEnd = true;
  bool canDoReachEnd = true;
  final Future<void> Function() onReachEnd;
  final Function(double) onScroll;
  final double reachEndDistance;

  ListViewController({@required this.scrollController, this.reachEndDistance = 15, Function(double) onScroll, Future<void> Function() onReachEnd}) :
        this.onScroll = onScroll == null ? ((_){}) : onScroll,
        this.onReachEnd = onReachEnd == null ? ((_)async{}) : onReachEnd {
    scrollController.addListener((){
      offset = scrollController.offset;
      this.onScroll(offset);
      if(_canDoReachEnd && canDoReachEnd && scrollController.offset != null && scrollController.position != null && scrollController.offset >= scrollController.position.maxScrollExtent - reachEndDistance){
        _canDoReachEnd = false;
        onReachEnd().then((_){
          _canDoReachEnd = true;
        });
      }
    });
  }

}