import 'dart:async';

import 'package:dogdeme/Dogde.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Heart extends RectangleComponent{
 bool hit =false;
 int cNum = 0;
 double currTime = 0, maxTime = 1.5, decTime = 1;

  Heart({required super.position, required super.size, required int num, Color color = Colors.pink,}) :super(
    anchor: Anchor.center, 
     paint: Paint()
        ..color = color
        ..style = PaintingStyle.fill,
  ){
    cNum = num;
  }
}