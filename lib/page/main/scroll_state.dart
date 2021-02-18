
import 'package:flutter/material.dart';


class ScrollPageState extends ChangeNotifier{

  double position = 0;

  getScroll(){
    return position;
  }

  setScroll(double position){
    return position = position;
  }

  notify(){
    notifyListeners();
  }
}