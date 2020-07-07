import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:virusapp/virus_game.dart';

class GameView {
  final VirusGame game;
  Sprite bgSprite;
  Rect bgRect;
  bool audioActive = false;
  GameView(this.game){
    bgSprite = Sprite('bg/background.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
  }
  void startAudio() {
    audioActive = true;
    Flame.bgm.play('inGame.mp3');
  }
  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}