import 'package:flutter/material.dart';

class MyMapSize {
  static final MyMapSize _instance = MyMapSize._internal();

  // passes the instantiation to the _instance object
  factory MyMapSize() => _instance;

  //initialize variables in here
  MyMapSize._internal();

  double _height = 20;
  double _width = 20;
  bool isFinish = false;

  double get myHeight => _height;
  double get myWidth => _width;

  //short setter for my variable
  set setMyWidth(double newWidth) {
    _width = newWidth;
    isFinish = true;
  }

  set setMyHeight(double newHeight) {
    _height = newHeight;
    isFinish = true;
  }
}
