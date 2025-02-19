import 'package:dogdeme/Dogde.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  Dogde game = Dogde();
  runApp(GameWidget(game: game));
}

