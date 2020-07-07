import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:virusapp/virus_game.dart';

class StartButton{
  final VirusGame game;
  Rect rect;
  Sprite startButton, paLogo;
  StartButton(this.game){
    startButton = Sprite('views/start_button.png');
    paLogo = Sprite('views/pa-logo.png');
  }

  void render(Canvas canvas){
    double widthStartButton = startButton.image.width.toDouble() / 2;
    rect = Rect.fromLTWH(
        centerHorizontally(startButton) + widthStartButton / 2,
        centerVertically(startButton),
        widthStartButton,
        startButton.image.height.toDouble() / 2
    );
    startButton.renderRect(canvas, rect);
    paLogo.renderRect(canvas, new Rect.fromLTWH(centerHorizontally(paLogo), 100 ,paLogo.image.width.toDouble(), paLogo.image.height.toDouble()));
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