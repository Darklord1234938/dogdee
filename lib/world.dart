import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:dogdeme/Dogde.dart';
import 'package:dogdeme/ball.dart';
import 'package:dogdeme/player.dart';

class NewWorld extends World with HasGameRef<Dogde> {
  int point = 0;
  double currTime = 0, maxTime = 2, decTime = 1; 
  late TextPaint textHealth, textPoint;

  @override
  Future<void> onLoad() async {
    currTime = maxTime;

    await super.onLoad();

    add(Player());
    add(Ball());

    // Initialize textPaint
    textHealth = TextPaint(
      style: const TextStyle(
        fontSize: 48.0,
        fontFamily: 'Awesome Font',
        color: Colors.black,
      ),
    );

    // Initialize textPaint
    textPoint = TextPaint(
      style: const TextStyle(
        fontSize: 48.0,
        fontFamily: 'Awesome Font',
        color: Colors.black,
      ),
    );
  }

  @override
  void update(double dt){
    if(gameRef.world.firstChild<Player>()!.currHp > 0){
    currTime -= decTime * dt;
      if(currTime <= 0){
      currTime = maxTime;
      point++;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textHealth.render(
      canvas,
      (gameRef.world.firstChild<Player>()!.currHp > 0)?(point >= 1000)?'You won you have more than 1000 points':'Health:' + gameRef.world.firstChild<Player>()!.currHp.toString() + ',Points:' + point.toString():'Game Over Press f5' + ',Points:' + point.toString(),
      (gameRef.world.firstChild<Player>()!.currHp > 0 || point <= 1000)? Vector2(-gameRef.size.x /2, -gameRef.size.y /2): Vector2(0, 0),
      anchor: (gameRef.world.firstChild<Player>()!.currHp > 0 || point <= 1000)? Anchor.topLeft : Anchor.center, // More natural for text placement
    );
  }
}