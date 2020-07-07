import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:virusapp/virus_game.dart';

class RestartButton{
  final VirusGame game;
  Rect rect;
  Sprite paLogo;

  RestartButton(this.game){
    paLogo = Sprite('views/game-over.png');

  }

  void render(Canvas canvas) {
    paLogo.renderRect(canvas, new Rect.fromLTWH(centerHorizontally(paLogo), 100 ,paLogo.image.width.toDouble(), paLogo.image.height.toDouble()));
  }

  void update(double time){

  }

  void onTapDown(){
    game.virusSpawner.start();
  }

  double centerHorizontally(Sprite sprite){
    return (game.screenSize.width / 2 - sprite.image.width.toDouble() / 2);
  }

  double centerVertically(Sprite sprite){
    return (game.screenSize.height / 2 - sprite.image.height.toDouble() / 2);
  }

}