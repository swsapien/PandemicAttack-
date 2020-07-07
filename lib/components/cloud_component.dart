import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:virusapp/virus_game.dart';

class CloudComponent{
  final VirusGame game;
  Rect rect;
  Sprite startButton;
  Offset position;
  double widthStartButton;
  bool reverse = false;
  CloudComponent(this.game){
    startButton = Sprite('cloud.png');
    position = Offset.zero;
  }

  void render(Canvas canvas){
    widthStartButton = startButton.image.width.toDouble() / 4;
    
    
    rect = Rect.fromLTWH(
        position.dx,
        centerVertically(startButton),
        widthStartButton,
        startButton.image.height.toDouble() / 4
    );
    startButton.renderRect(canvas, rect);
  }
  void update(double time){
    double posX = 0;
    if(!reverse)
    {
      posX = position.dx + 1;
      reverse = (position.dx + 1) <= (game.screenSize.width - widthStartButton) ? false : true;
    }else{
      posX = position.dx - 1;
      reverse = (position.dx - 1) >= 0.0 ? true : false;
    }

    position = Offset(posX, widthStartButton);
  }
  double centerHorizontally(Sprite sprite){
    return (game.screenSize.width / 2 - sprite.image.width.toDouble() / 2);
  }

  double centerVertically(Sprite sprite){
    return (game.screenSize.height / 2 + sprite.image.height.toDouble() / 2);
  }

}