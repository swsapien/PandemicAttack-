import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:virusapp/components/cloud_component.dart';
import 'package:virusapp/virus_game.dart';

class HomeView {
  final VirusGame game;
  Rect bgRect;
  Sprite bgSprite;
  CloudComponent cloudComponent;
  bool audioActive = false;
  HomeView(this.game){
    bgSprite = Sprite('bg/bkg-home.png');
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width,
      game.screenSize.height,
    );
    cloudComponent = CloudComponent(this.game);
  }
  void startAudio() {
    audioActive = true;
    Flame.bgm.play('startGame.mp3');
  }
  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
    cloudComponent.render(canvas);
  }

  void update(double time) {
    cloudComponent.update(time);
  }
}