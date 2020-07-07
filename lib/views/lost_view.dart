import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:virusapp/virus_game.dart';

class LostView {
  final VirusGame game;
  Rect bgRect, bgBackRect;
  Sprite bgSprite, backSprite;
  double backWidth = 140;
  double backHeight = 40;
  bool audioActive = false;
  LostView(this.game) {
    bgSprite = Sprite('bg/bkg-end.png');
    backSprite = Sprite('back.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
    bgBackRect = Rect.fromLTWH(
      10,
      20,
      backWidth,
      backHeight
    );
  }
  void startAudio() {
    audioActive = true;
    Flame.bgm.play('lostGame.mp3');
  }
  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
    backSprite.renderRect(canvas, bgBackRect);
  }

  void update(double time) {}
}