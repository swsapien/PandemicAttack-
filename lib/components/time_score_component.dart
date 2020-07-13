import 'dart:ui';
import 'package:flame/time.dart';
import 'package:flutter/painting.dart';
import 'package:virusapp/virus_game.dart';

class TimeScoreComponent {
  final VirusGame game;
  Timer interval;
  int elapsedSecs = 0;
  int elapsedMins = 0;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  String elapsed;

  TimeScoreComponent(this.game){
    painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );

    interval = Timer(1, repeat: true, callback: () {
      elapsedSecs += 1;
      if(elapsedSecs == 60) {
        elapsedSecs = 0;
        elapsedMins += 1;
      }
    });
    interval.start();

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 14,
      fontFamily: "8bitpusab",
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
      elapsed = "${elapsedMins.toString() }:${elapsedSecs.toString() }";
      painter.text = TextSpan(
        text: "Time: $elapsed",
        style: textStyle,
      );
      painter.layout();
      position = Offset(20, 20);
      interval.update(t);
  }

  void resetTime(){
    elapsedSecs = 0;
    elapsedMins = 0;
  }



}