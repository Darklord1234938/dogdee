import 'dart:async';

import 'package:dogdeme/ball.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent with CollisionCallbacks{
  late Effect dieEffect;
 bool hit =false;
 double currTime = 0, maxTime = 1.5, decTime = 1;
 int currHp = 0, maxHp = 3; 

  @override
  FutureOr<void> onLoad() async {
    position =  Vector2(300, 200);
    size = Vector2(50, 50);
    anchor = Anchor.center;
    paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;
    currTime = maxTime;
    add(RectangleHitbox());
    currHp = maxHp;
    dieEffect = OpacityEffect.to( 0,EffectController(duration: 0.75),);
    decorator.addLast(PaintDecorator.tint(const Color.fromARGB(3, 255, 255, 255)));
}

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other){
      if(other is Ball){
        paint = Paint()
        ..color = const Color.fromARGB(255, 18, 70, 112);
        if(!hit){
          TakeDamage();
          hit = true;
        }
      }
      super.onCollisionStart(intersectionPoints, other);
  }

  void move(Vector2 _axis, double _speed){
    if(currHp > 0){
      position.x +=_speed * _axis.x;
      position.y +=_speed * _axis.y;
    }
  }

  void TakeDamage(){
    currHp--;

    if(currHp <= 0){
      add(dieEffect);
    }
  }

@override
void update(double dt){
  if(currHp > 0){
    if(hit){
      currTime -= decTime * dt;
      if(currTime <= 0){
        currTime = maxTime;
        hit = false;
        paint = Paint()
          ..color = Colors.blue;
    }
  }
}
}}