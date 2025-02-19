import 'dart:async';

import 'package:dogdeme/player.dart';
import 'package:dogdeme/world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dogde extends FlameGame<NewWorld> with KeyboardEvents, HasCollisionDetection{
  Dogde()
    : super(world: NewWorld()){

 }

  Color backgroundColor(){
    return Colors.green;
  }


  final Set<LogicalKeyboardKey> _keysPressed = {};

  Vector2 dire = new Vector2(0, 0);
  bool hor = false, ver = false;

  @override
  Future<void> onLoad() async{
    super.onLoad();

    //debugMode = true;
  }



  @override 
 KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      _keysPressed.add(event.logicalKey); // Store  key
    } else if (event is KeyUpEvent) {
      _keysPressed.remove(event.logicalKey); // Remove  key
    }

    return KeyEventResult.handled;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final _player = world.firstChild<Player>();
    if (_player != null) {
      const double speed = 200; 

      if (_keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        dire.x = 1;
      }
      else if (_keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        dire.x = -1;
      }
      else{
        dire.x = 0;
      }

      if (_keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        dire.y = -1;
      }
      else if (_keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        dire.y = 1;
      }
      else{
        dire.y = 0;
      }

      if(_player.y >= size.y /2 - _player.size.y /2){
        _player.y = size.y /2 - _player.size.y /2;
      }else if(_player.y <= -size.y /2 + _player.size.y /2){
        _player.y = -size.y /2 + _player.size.y /2;
      }
      
      
      if(_player.x >= size.x / 2 - _player.size.x /2){
        _player.x = size.x /2 - _player.size.x /2;
      }else if(_player.x <= -size.x /2 + _player.size.x /2){
        _player.x = -size.x /2 + _player.size.x /2;
      }
   
        _player.move(dire, speed * dt);
    }
  }


}