import 'dart:ui';
import 'package:flame/time.dart';
import 'package:flutter/painting.dart';
import 'package:virusapp/virus_game.dart';

class TryAgainComponent {
  final VirusGame game;
  Timer interval;
  int score = 0;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  Size screenSize;

  TryAgainComponent(this.game){
    painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 24,
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
  }

  void render(Canvas c) {
     painter.text = TextSpan(
      text: "try again",
      style: textStyle,
    );
    painter.layout();
    position = Offset(screenSize.width/2 - painter.width /2 , screenSize.height/1.3);
    painter.paint(c, position);
  }

  void update(double t) {
  }
}