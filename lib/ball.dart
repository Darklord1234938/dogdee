import 'dart:async';

import 'package:dogdeme/Dogde.dart';
import 'package:dogdeme/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Ball extends RectangleComponent with HasGameRef<Dogde> {
  Vector2 speed = Vector2(300, 300); // Initial speed
  Vector2 dire = Vector2(1, 1); // Movement direction
  late Effect effect;

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);
    position = Vector2(0, 0); // Start at the center
    anchor = Anchor.center;

    paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    add(RectangleHitbox());

    effect = OpacityEffect.to( 0,EffectController(duration: 0.75),);
  }

  void update(double dt){
    	if(gameRef.world.firstChild<Player>()!.currHp <= 0){
        add(effect);
      }else{
      position.y += speed.y * dire.y *dt;
      position.x += speed.x * dire.x *dt;

      if(position.y >= gameRef.size.y / 2 - size.y /2 || position.y <= -gameRef.size.y/2){
        speed.y += 5;
        dire.y *= -1;
      }

      if(position.x >= gameRef.size.x / 2 - size.x /2 || position.x <= -gameRef.size.x / 2){
        speed.x += 5;
        dire.x *= -1;
      }
    }
  }
}