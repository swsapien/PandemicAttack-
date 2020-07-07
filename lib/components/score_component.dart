import 'dart:ui';
import 'package:flame/time.dart';
import 'package:flutter/painting.dart';
import 'package:virusapp/virus_game.dart';

class ScoreComponent {
  final VirusGame game;
  Timer interval;
  int score = 0;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  Size screenSize;

  ScoreComponent(this.game){
    painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 14,
      fontFamily: "GameFont",
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
    screenSize = this.game.screenSize;
    score = this.game.score;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    score = this.game.score;
    painter.text = TextSpan(
      text: "Score: ${score.toString() }",
      style: textStyle,
    );
    painter.layout();
    position = Offset(screenSize.width-140, 20);
  }

  void reset(){
    score = 0;
  }
}